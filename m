Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269654AbUJSScK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269654AbUJSScK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269586AbUJSS07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:26:59 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:54760 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S270090AbUJSRzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:55:09 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Martin Waitz <tali@admingilde.org>
Date: Tue, 19 Oct 2004 10:54:50 -0700
MIME-Version: 1.0
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <4174F27A.1499.1645EC81@localhost>
In-reply-to: <20041019170111.GG3618@admingilde.org>
References: <4173BA7D.32320.11833A1D@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz <tali@admingilde.org> wrote:

> On Mon, Oct 18, 2004 at 12:43:41PM -0700, Kendall Bennett wrote:
> > I am not sure what you mean by basic text output? If you mean to a 
> > display, then yes, embedded boxes using U-Boot and OpenBIOS usually do 
> > not have any text output. But if you mean serial output that is usually 
> > the method of choice for the embedded machines that don't have support 
> > for a physical display in the firmware.
> 
> I mean: text output on the preferred console.
> 
> Embedded devices have a serial console anyway and all other
> machines have firmware support for drawing text. 

No, all other machines don't have firmware support for drawing text. That 
is why we wrote this code in the first place.

> That is: switching into graphics mode can be done by the firmware,
> bootloader, or by userspace and doesn't have to be in the kernel. 

U-Boot and OpenBIOS on the machines we are working with do not have any 
support for initialising the video card. Both could be modified but at 
present neither support this so the only way to bring up the video card 
for framebuffer console support is in the kernel.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


