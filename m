Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268497AbUJPFKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268497AbUJPFKs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 01:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268511AbUJPFKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 01:10:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:57064 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268497AbUJPFKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 01:10:43 -0400
Subject: Re: remap_page_range64() for PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Glenn Burkhardt <glenn@aoi-industries.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041016034642.F1DD0C60D@aoi-industries.com>
References: <20041016034642.F1DD0C60D@aoi-industries.com>
Content-Type: text/plain
Message-Id: <1097903265.8964.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 15:07:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-16 at 13:46, Glenn Burkhardt wrote:
> I'm writing an application to run on a PowerPC with a 2.4 embedded
> Linux kernel, and I want to make device registers for our custom
> hardware accessable from user space with mmap().  The physical address
> of the device is above the 4gb boundary (we attach to the 440's
> external peripheral bus), so a standard 'remap_page_range()' call
> won't work.
>
>.../...

I suggest you post this to the linuxppc-embedded or linuxppc-dev
lists (see https://ozlabs.org/mailman/listinfo/linuxppc-embedded)

Ben.


