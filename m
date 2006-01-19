Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWASSKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWASSKD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWASSKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:10:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:48835 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751367AbWASSKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:10:01 -0500
Date: Thu, 19 Jan 2006 10:09:47 -0800
From: Greg KH <greg@kroah.com>
To: linux-m68k@vger.kernel.org, geert@linux-m68k.org, zippel@linux-m68k.org
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: License oddity in some m68k files
Message-ID: <20060119180947.GA25001@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone recently pointed out to me the following wording on some of the
m68k files that reads:

|               Copyright (C) Motorola, Inc. 1990
|                       All Rights Reserved
|
|       THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
|       The copyright notice above does not evidence any
|       actual or intended publication of such source code.

This shows up in the following files:
	arch/m68k/fpsp040/bindec.S
	arch/m68k/fpsp040/binstr.S
	arch/m68k/fpsp040/bugfix.S
	arch/m68k/fpsp040/decbin.S
	arch/m68k/fpsp040/do_func.S
	arch/m68k/fpsp040/fpsp.h
	arch/m68k/fpsp040/gen_except.S
	arch/m68k/fpsp040/get_op.S
	arch/m68k/fpsp040/kernel_ex.S

and seems to predate the bitkeeper tree, so it's a bit hard to figure
out where they came from.

Any ideas of how they made it into our tree?  And any chance of
correcting them to be the correct license or removing them?

thanks,

greg k-h
