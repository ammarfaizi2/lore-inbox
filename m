Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVEYV0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVEYV0N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 17:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVEYV0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 17:26:13 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:13973 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261563AbVEYV0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 17:26:11 -0400
Date: Wed, 25 May 2005 17:25:38 -0400
From: Tom Vier <tmv@comcast.net>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050525212538.GC28913@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <20050525205841.GB28913@zero> <Pine.OSF.4.05.10505252303300.23201-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10505252303300.23201-100000@da410.phys.au.dk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 11:05:05PM +0200, Esben Nielsen wrote:
> Long interrupt handlers can be interrupt by _tasks_, not only other
> interrupts! An audio application running in userspace can be scheduled
> over an ethernet interrupt handler copying data from the
> controller into RAM (without DMA).

Doesn't that greatly increase the risk of the hardware overrunning it's
buffer?

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
