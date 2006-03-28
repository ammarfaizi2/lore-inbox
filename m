Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWC1Ual@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWC1Ual (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWC1Uak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:30:40 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:54720 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S932155AbWC1Uaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:30:39 -0500
Date: Tue, 28 Mar 2006 22:30:34 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG] PS/2-mouse not found in 2.6.16
In-Reply-To: <Pine.LNX.4.58.0603282044060.2538@be1.lrz>
Message-ID: <Pine.LNX.4.58.0603282226270.2450@be1.lrz>
References: <Pine.LNX.4.58.0603272148050.2266@be1.lrz>
 <d120d5000603271256g6ff971daq57282287fd1d5434@mail.gmail.com>
 <Pine.LNX.4.58.0603282044060.2538@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Bodo Eggert wrote:
> On Mon, 27 Mar 2006, Dmitry Torokhov wrote:
> > On 3/27/06, Bodo Eggert <7eggert@gmx.de> wrote:

> > > With kernel 2.6.16, my Logitech mouse is no longer detected (not reported
> > > in dmesg, not working).
> > >
> > 
> > Does it help if you comment out call to quirk_usb_handoff_ohci() (your
> > USB host controller is an OHCI one, isn't it?) in
> > drivers/usb/host/pci-quirks.c::quirk_usb_early_handoff()?
> 
> It's uhci, and turning
> drivers/usb/host/pci-quirks.c::quirk_usb_early_handoff into a noop did not 
> help.

Now I copied (symlinked) the input/mouse directory from 2.6.15, and it 
works.
-- 
Top 100 things you don't want the sysadmin to say:
60. We're standardizing on AIX.
