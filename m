Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265627AbTFSGLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 02:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbTFSGLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 02:11:46 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:50374 "EHLO
	rwcrmhc12.attbi.com") by vger.kernel.org with ESMTP id S265627AbTFSGLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 02:11:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Eric Altendorf <EricAltendorf@orst.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>,
       swsusp-devel-request@lists.sourceforge.net
Subject: Re: RTC causes hard lockups in 2.5.70-mm8
Date: Tue, 17 Jun 2003 12:34:00 -0700
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.55L-032.0306122205210.4915@unix48.andrew.cmu.edu> <1055492730.5162.0.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1055492730.5162.0.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306171232.27887.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 June 2003 01:25, Alan Cox wrote:
> On Gwe, 2003-06-13 at 03:12, Nathaniel W. Filardo wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > If I set CONFIG_RTC=m and rebuild, when the kernel autoloads
> > rtc.ko the system immediately locks hard, not responding even to
> > magic SysRq series. Backing out either of the rtc-* patches from
> > -mm8 does not seem to fix the problem.
>
> It seems to be ALI + ACPI related but I dont yet understand what is
> going on
>

I'm running a Toshiba Libretto L2 (Crusoe, ACPI, ALI).  I don't have 
any troubles with 2.5.63 (which happens to be my current stable 
kernel).  However, I've been playing with 2.4.21 with just the swsusp 
patches (not -ac) and with most builds I've tried there, invoking 
hwclock always hangs the machine (which I assume is rtc related).

Let me know if I can provide any more information...

Eric


