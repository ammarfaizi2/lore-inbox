Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268086AbUIPOUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUIPOUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268090AbUIPOUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:20:47 -0400
Received: from holomorphy.com ([207.189.100.168]:46500 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268086AbUIPOU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:20:26 -0400
Date: Thu, 16 Sep 2004 07:20:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040916142018.GS9106@holomorphy.com>
References: <20040916024020.0c88586d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916024020.0c88586d.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 02:40:20AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/
> - Added lots of Ingo's low-latency patches
> - Lockmeter doesn't compile.  Don't enable CONFIG_LOCKMETER.
> - Several architecture updates

Please remove include/asm-sh64/smp_lock.h; they missed the smp_lock.h
consolidation while sitting out-of-tree and/or in the process of
forward porting to 2.6


-- wli
