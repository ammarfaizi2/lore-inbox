Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVCIQ0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVCIQ0K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVCIQ0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:26:10 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:2309 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261651AbVCIQ0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:26:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=q1SxnceQO29HiP0557S/kwuo6xC9zZumGiP+5D3vw6UuA+ALPuWPW/Ym6rXz90w/7Wr84dSkdfdRkARzsb3v6MqQjV9XE8kUh+iG/PzbW/wfu3HPQIKOA8IR/9S8l484l/uqxoCW0ceEZ6bOJ7XXKj5lioyz06bz0DzUg32b+Dg=
Message-ID: <58cb370e05030908267f0fadbe@mail.gmail.com>
Date: Wed, 9 Mar 2005 17:26:03 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: CaT <cat@zip.com.au>
Subject: Re: Linux 2.6.11-ac1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050309072646.GG1811@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1110231261.3116.90.camel@localhost.localdomain>
	 <20050309072646.GG1811@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005 18:26:46 +1100, CaT <cat@zip.com.au> wrote:
> On Mon, Mar 07, 2005 at 09:34:22PM +0000, Alan Cox wrote:
> > For a couple of reasons I've not yet merged Greg's 2.6.11.1 yet but this
> > diff should actually apply to either right now.
> >
> > 2.6.11-ac1
> > o     Fix jbd race in ext3                            (Stephen Tweedie)
> >
> > Carried over from 2.6.10-ac
> 
> BTW. What's the probability of the ITE driver making it into the stock
> kernel?

It can be merged if somebody fix it to always force controller into
non-RAID mode and remove RAID mode support (which currently
does nothing more besides complicating the driver and making special
commands unusable).
