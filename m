Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWC1Spn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWC1Spn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWC1Spn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:45:43 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:42198 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751214AbWC1Spm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:45:42 -0500
Date: Tue, 28 Mar 2006 20:45:38 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: dtor_core@ameritech.net
cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] PS/2-mouse not found in 2.6.16
In-Reply-To: <d120d5000603271256g6ff971daq57282287fd1d5434@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0603282044060.2538@be1.lrz>
References: <Pine.LNX.4.58.0603272148050.2266@be1.lrz>
 <d120d5000603271256g6ff971daq57282287fd1d5434@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2006, Dmitry Torokhov wrote:
> On 3/27/06, Bodo Eggert <7eggert@gmx.de> wrote:

> > With kernel 2.6.16, my Logitech mouse is no longer detected (not reported
> > in dmesg, not working).
> >
> 
> Does it help if you comment out call to quirk_usb_handoff_ohci() (your
> USB host controller is an OHCI one, isn't it?) in
> drivers/usb/host/pci-quirks.c::quirk_usb_early_handoff()?

It's uhci, and turning
drivers/usb/host/pci-quirks.c::quirk_usb_early_handoff into a noop did not 
help.
-- 
Top 100 things you don't want the sysadmin to say:
22. hey, what does mkfs do?
