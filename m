Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbUJ3TCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUJ3TCu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUJ3TCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:02:50 -0400
Received: from mail2.ameuro.de ([195.140.232.8]:57860 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id S261248AbUJ3TCs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:02:48 -0400
Date: Sat, 30 Oct 2004 19:01:28 +0000
From: Anders Larsen <al@alarsen.net>
Subject: Re: [2.6 patch] QNX4 cleanups
To: Adrian Bunk <bunk@stusta.de>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
References: <20041030180702.GT4374@stusta.de>
	<20041030183422.GY24336@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041030183422.GY24336@parcelfarce.linux.theplanet.co.uk>
	(from viro@parcelfarce.linux.theplanet.co.uk on Sat Oct 30 20:34:22 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1099162888l.2673l.0l@errol.alarsen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-AEV-SpamCheck: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 08:07:02PM +0200, Adrian Bunk wrote:
> The patch below does the following cleanups in the QNX4 fs:
> - remove two unused global functions

If you remove any code inside the #ifdef CONFIG_QNX4FS_RW we might
as well remove the option "config QNX4FS_RW" altogether.
It's horribly broken, and I don't intend to fix it; while I was
thinking about how to properly implement write-support, somebody else
went away and did it. As that alternative seems to work well and is
being actively maintained, I won't try to reinvent it.

Cheers
 Anders


