Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbUK3DNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUK3DNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUK3DNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:13:32 -0500
Received: from ems.hclinsys.com ([203.90.70.242]:27666 "EHLO ems.hclinsys.com")
	by vger.kernel.org with ESMTP id S261936AbUK3DN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:13:27 -0500
Subject: Re: usage of WIN_SMART
From: Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>
To: Edward Falk <efalk@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41ABB93F.8060206@google.com>
References: <1101290068.3787.26.camel@myLinux>
	 <8783be6604112611137bcbfb61@mail.gmail.com>  <41ABB93F.8060206@google.com>
Content-Type: text/plain
Message-Id: <1101784239.3789.7.camel@myLinux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 30 Nov 2004 08:40:40 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Edward,
	I am grateful for such a descriptive reply. I was exploring through the
ide-disk driver interface, which provides the SMART readings through the
ioctl, using WIN_SMART. At the end its calling an inb and an outb to the
regs, like u said, feature regs and all. Is it possible to do it
directly with an inb and outb from a C program, avoiding the
complexities involved in the WIN_SMART command.

And, can u help me out with the syntax of WIN_SMART class of ioctl?
I know that a buffer like

	buffer = {WIN_SMART, 0, SMART_READ_VALUES, 1};
and it is passed to the ioctl.

I have seen the significance of 1st element(WIN_SMART) and 3rd element
(SMART_READ_VALUES) in the ide-disk module's code.

What does the second argument and the fourth argument signify?


Can u help me with this also, coz I've been digging for this a long
time, and haven't been that successfull!!




-- 
Thanks & Regards,

Jagadeesh Bhaskar P
R&D Engineer
HCL Infosystems Ltd
Pondicherry
INDIA

