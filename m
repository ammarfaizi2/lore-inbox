Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRCWImn>; Fri, 23 Mar 2001 03:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130253AbRCWImX>; Fri, 23 Mar 2001 03:42:23 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:17171 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S129486AbRCWImM>; Fri, 23 Mar 2001 03:42:12 -0500
Message-ID: <3ABB0B03.851D766A@ix.netcom.com>
Date: Fri, 23 Mar 2001 03:36:19 -0500
From: Jeffrey Ingber <jhingber@ix.netcom.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-SMP i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: use the kernel to change an irq?
In-Reply-To: <Pine.LNX.4.32.0103222258140.388-100000@velius.chaos2.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacob Luna Lundberg wrote:
> 
> Oh Great Gurus:
> 
> I have an agp video card that seems quite picky about interrupts, and a
> bios that is insisting on sharing the video card's interrupt with whatever
> is in the first pci slot.  So my question is, is there any way for the

Your problem is most likely _not_ an IRQ issue, but a bus mastering
issue.  Your AGP and PCI most likely share the same busmastering line. 
The IRQ should not be an issue.

-- 
Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)

"Windows 95 is a 32-bit shell for a 16-bit extension to an 
8-bit  operating system designed for a 4-bit microprocessor
 by a 2-bit company that can't stand one bit of competition."
