Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVKGSBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVKGSBa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbVKGSBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:01:30 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:15302 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964988AbVKGSB3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:01:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AFyVqv2bLdRKURFbuUFFAtZIKmepldEDcfrrbGytVcu4Mz45IrP6SQEyfNk9pUROa8UJtbUXKmiJw2ze6Ukg5O1T8eyhGURdfIpzEkJtGyXYu6mI1vMRTGOetIBKXtx/uiacITxlddx8HW4vMbabz8yA9dSd+KogZW5ZPefauHI=
Message-ID: <5bdc1c8b0511071001s2d990e72s812c195d5614a894@mail.gmail.com>
Date: Mon, 7 Nov 2005 10:01:28 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3D video card recommendations
Cc: Gerhard Mack <gmack@innerfire.net>, LKML <linux-kernel@vger.kernel.org>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hugo Mills <hugo-lkml@carfax.org.uk>, Nix <nix@esperi.org.uk>,
       Anshuman Gholap <anshu.pg@gmail.com>, Diego Calleja <diegocg@gmail.com>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>, arjan@infradead.org
In-Reply-To: <1131386032.14381.110.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1131112605.14381.34.camel@localhost.localdomain>
	 <1131349343.2858.11.camel@laptopd505.fenrus.org>
	 <1131367371.14381.91.camel@localhost.localdomain>
	 <20051107152009.GA20807@shuttle.vanvergehaald.nl>
	 <20051107180045.ec86a7f2.diegocg@gmail.com>
	 <1131384624.14381.106.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511071243350.9444@innerfire.net>
	 <1131386032.14381.110.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 2005-11-07 at 12:44 -0500, Gerhard Mack wrote:
>
> >
> > Way ahead of you .. I have such a list since I own the PCI-E X300 ;)
> >
> > Your better off than I am since I bought mine two months ago.
> >
> >       Gerhard
>
> Are you running this on a x86_64 machine?
>
> -- Steve

Steven,
  Hi . I run my ATI PCI_Express card on a 64-bit kernel. (2.6.14-rt6)
It works fine for my needs, although as I said earlier my glxgears
numbers are nothing to shout about:

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV370
5B60 [Radeon X300 (PCIE)]
0000:01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]

mark@lightning ~ $ glxgears
Xlib:  extension "XFree86-DRI" missing on display ":0.0".
3170 frames in 5.0 seconds = 634.000 FPS
3416 frames in 5.0 seconds = 683.200 FPS
3294 frames in 5.0 seconds = 658.800 FPS

mark@lightning ~ $

   I'm using the radeon driver from the Xorg-X11 package. The only
problem I've run into which remains unsolved is that when I run either
Quicken or IE6 under Crossover Office 5.0 all of the icons in those
windows programs show up in black and white, not color, so they are
somewhat unreadable. Other than that no real problems.

- Mark
