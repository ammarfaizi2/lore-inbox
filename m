Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWBCTcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWBCTcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945915AbWBCTcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:32:11 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:45812 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945916AbWBCTcK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:32:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZzTfhE6oz+7gkKtMfy1/WyPg8gfZmf6KdRGWJ3aMseWiMf36AQHrYvo+lW8NZqwVkyBb07siXET8kuzFbEKoLHuUsfj6VMaNQr55dkRUZBVW4xbrCOTOMvrSYdeTpNB1PLnl/XWJPllIQ1JpJR+6WhyvxwgoFqTF5IcVF95p7+o=
Message-ID: <5a4c581d0602031132s6af9373bo9515707d84093c8c@mail.gmail.com>
Date: Fri, 3 Feb 2006 20:32:09 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: WLAN drivers
Cc: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
In-Reply-To: <1138969138.8434.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138969138.8434.26.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/06, Panagiotis Issaris <takis.issaris@uhasselt.be> wrote:

[snip]

> And now the reason I'm sending this to this mailing list: Which wireless
> network cards are you all using and which ones would you recommend? Is
> anyone using USB wireless network cards (without using ndiswrapper)?

I have had no problem with a USR2210 PC Card for my Dell laptop,
 running the soon-to-be-in-mainline ACX drivers by Andi Mohr and
 more recently Denis Vlasenko. This driver is at the moment in -mm.

The newer laptop runs an Intel 2200BG with in-kernel drivers fine, apart
 from not dealing well with being put in monitor mode (firmware restarts
 every few seconds gobbling 70% CPU even with very low traffic). As a
 matter of fact, current drivers won't even allow you to put the card in
 monitor mode - you have to explicitly enable the code by editing the
 source files; that's intentional as the developers know about the issue.

--alessandro

 "Somehow all you ever need is, never really quite enough, you know"

   (Bruce Springsteen - "Reno")
