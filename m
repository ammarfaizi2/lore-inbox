Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTJIUVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTJIUVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:21:11 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:27314 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262386AbTJIUVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:21:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16261.49965.101563.951148@gargle.gargle.HOWL>
Date: Thu, 9 Oct 2003 22:21:01 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Arun Sharma <arun.sharma@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: 2.6.0-test7 BLK_DEV_FD dependence on ISA breakage
In-Reply-To: <3F85A670.10405@intel.com>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
	<16261.25288.125075.508225@gargle.gargle.HOWL>
	<20031009070505.00470202.akpm@osdl.org>
	<3F85A670.10405@intel.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arun Sharma writes:
 > Andrew Morton wrote:
 > > Perhaps we should just back it out and watch more closely next time someone
 > > tries to fix it?
 > 
 > I'm fine with backing out the Kconfig part of the patch. Perhaps this is one of those things where an explicit list of platforms which do support this feature is unavoidable ? 

The Kconfig patch also broke floppy on x86-64. Since no x86-64 board
to date has any ISA _slots_, x86-64 doesn't even give you the option
of enabling CONFIG_ISA...
