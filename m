Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbWBYVEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWBYVEu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 16:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWBYVEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 16:04:50 -0500
Received: from [192.231.160.6] ([192.231.160.6]:14302 "EHLO cinder.waste.org")
	by vger.kernel.org with ESMTP id S1161113AbWBYVEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 16:04:49 -0500
Date: Sat, 25 Feb 2006 15:04:54 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060225210454.GL13116@waste.org>
References: <0.399206195@selenic.com> <4.399206195@selenic.com> <20060224221909.GD28855@flint.arm.linux.org.uk> <20060225065136.GH13116@waste.org> <20060225084955.GA27538@flint.arm.linux.org.uk> <20060225145412.GI13116@waste.org> <20060225180521.GB15276@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225180521.GB15276@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 06:05:21PM +0000, Russell King wrote:
> It seems that you're missing this case - the case where lib/inflate.c
> is used elsewhere in the kernel apart from the boot time decompressors.

I think you must be getting confused with lib/zlib. lib/inflate.c is
only used at boot.

-- 
Mathematics is the supreme nostalgia of our time.
