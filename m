Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUCZAq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbUCZAoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:44:25 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:40205 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S263891AbUCZAlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:41:37 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <debian-devel@lists.debian.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: RE: Binary-only firmware covered by the GPL?
Date: Thu, 25 Mar 2004 16:41:23 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEEOLEAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2096
In-Reply-To: <20040325225423.GT9248@cheney.cx>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 25 Mar 2004 16:19:48 -0800
	(not processed: message from valid local sender)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
Reply-To: davids@webmaster.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Mar 25, 2004 at 11:08:03PM +0100, Adrian Bunk wrote:
> > There's another issue with these files:
> >
> <--  snip  -->
> >
> > The GPL says that you must give someone receiving a binary the source
> > code, and it says:
> >   The source code for a work means the preferred form of the work for
> >   making modifications to it.
> >
> >
> > This is perhaps a bit besides the main firmware discussion and IANAL,
> > but is this file really covered by the GPL?

> IMHO code that can be compiled would probably be the preferred form
> of the work.

	You are seriously arguing that the obfuscated binary of the firmware is the
preferred form of the firmware for the purpose of making modifications to
it?!

> The source to the firmware in many cases and probably even
> this one is very unlikely to be able to be compiled under Linux at all.

	What does it matter what it compiles under? The GPL is not Linux-specific.

> Also, unless the driver is written by the company producing the hardware
> itself even the author will likely not have the source code to the
> firmware and will only have a binary form (think reverse engineering).

	If you don't have the preferred form of something for the purpose of making
modifications to it, then you can't give that to people, so you *CAN'T* GPL
it. If you making an executable that derives from a GPL'd product and, for
example, lose the source code, you MAY NOT distribute the executable. You
must have the preferred form for the purpose of making modifications or you
are not able to GPL.

> IMHO a driver for a piece of hardware does not include the software that
> the hardware itself is running, just the software that the primary CPU
> itself is running. YMMV.

	But it does. This file contains the software that the hardware itself is
running. That's its sole purpose. Please tell me how you make modifications
to this file.

	DS

