Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbULQAgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbULQAgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbULQAgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:36:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:42983 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262309AbULQAfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:35:39 -0500
Subject: Re: [PATCH] 2.6.9 ide-probe and indentical old disks.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Gortmaker <penguin@muskoka.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41C21086.7030703@muskoka.com>
References: <41C21086.7030703@muskoka.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103239877.21806.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 23:31:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 22:47, Paul Gortmaker wrote:
> It seems that some old disks don't have a serial number, but ide-probe
> now compares serial numbers to determine if a slave disk is just a
> ghost image of the primary.  This breaks old hardware that has two
> identical model disks which don't report serial numbers.  The fix seems
> as simple as checking for zero length serial numbers before comparing.

Already fixed

