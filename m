Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUJRTuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUJRTuE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUJRTpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:45:31 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:33960 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S267649AbUJRToC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:44:02 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Martin Waitz <tali@admingilde.org>
Date: Mon, 18 Oct 2004 12:43:41 -0700
MIME-Version: 1.0
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <4173BA7D.32320.11833A1D@localhost>
In-reply-to: <20041018114443.GC3618@admingilde.org>
References: <416FB29A.11731.1C46848@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz <tali@admingilde.org> wrote:

> On Fri, Oct 15, 2004 at 11:20:58AM -0700, Kendall Bennett wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > It doesn't imply this at all. You set an initial mode with the BIOS
> > > during boot up. When your initrd runs you gain the ability to flip mode
> > > and do cool stuff - arguably it doesn't even need to be in initrd.
> > 
> > That works great on x86, but this solution was developed for PowerPC and 
> > MIPS embedded systems development not x86 desktop systems. For those 
> > platforms you either need a boot loader that can bring up the system into 
> > graphics mode
> 
> not neccessarily.
> 
> If anything goes wrong before console is initialized, then that
> could be displayed by the firmware. Is there any arch which doesn't
> have some basic text-output functunality in its firmware? 

I am not sure what you mean by basic text output? If you mean to a 
display, then yes, embedded boxes using U-Boot and OpenBIOS usually do 
not have any text output. But if you mean serial output that is usually 
the method of choice for the embedded machines that don't have support 
for a physical display in the firmware.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


