Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWAIPND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWAIPND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWAIPND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:13:03 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:39997 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932329AbWAIPNC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:13:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yb/MWA7pT70FDikPJ0LcNQ95amgCKXfRY2TUwg41O971ZL2H2YJUECC4KChbJvcr/MY4TrF5eht6/LFEp2FE8dmRVpspwMgtCC9c6EnEdQGTUMT3EoZvJnSXVA9ogt1Y59zVU4uKP/O4z2QDTZlMwKD01o9M7cLGNXCzSLHSC9I=
Message-ID: <d120d5000601090713v892991r4e5c2d3f1de5910d@mail.gmail.com>
Date: Mon, 9 Jan 2006 10:13:00 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Danny Brow <dan@fullmotions.com>
Subject: Re: Sluggish typing
Cc: Kernel-List <linux-kernel@vger.kernel.org>
In-Reply-To: <1136798337.30826.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1136798337.30826.9.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Danny Brow <dan@fullmotions.com> wrote:
> After trying numerous kernel versions I've had very sluggish typing in
> the console since 2.6.13-rcX (can't remember when it started). But I
> have to hit a key twice, cursor up or down does not show history, some
> times it does nothing, other times it acts like I hit tab-tab. I'm
> running 2.6.15 on 4 system, 2.6.15-rc2 on my laptop and they all have
> this problem. I have 2 servers right now with the same problem, I think
> they are 2.6.14.2. All custom configs. All the systems are intel
> p4/pd/centrino, various chipsets, i845, i875p, i925. Is their a patch or
> work around for this problem. I have spoke with a few other people with
> the same problem.
>
> Also sometimes it stops and all is fine for about 10 seconds, irq
> polling issue?
>

Try booting with "usb-handoff" on the kernel command line with 2.6.14
kernel. Unfortunately it seems that this parameter got broken in
2.6.15.

--
Dmitry
