Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265743AbUGHBol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265743AbUGHBol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 21:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUGHBoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 21:44:10 -0400
Received: from holomorphy.com ([207.189.100.168]:55777 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265743AbUGHBnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 21:43:16 -0400
Date: Wed, 7 Jul 2004 18:43:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
Message-ID: <20040708014311.GM21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <m2brir9t6d.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2brir9t6d.fsf@telia.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 03:36:10AM +0200, Peter Osterlund wrote:
> I created a test program that allocates a 300MB buffer and writes to
> all bytes sequentially. On my computer, which has 256MB RAM and 512MB
> swap, the program gets OOM killed after dirtying about 140-180MB, and
> the kernel reports:
> Out of Memory: Killed process 3421 (memalloc2).
> I ran "vmstat 1" during the test:

akpm, shall I revisit GFP_WIRED?


-- wli
