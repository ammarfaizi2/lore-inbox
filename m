Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbTE1FQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTE1FQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:16:27 -0400
Received: from holomorphy.com ([66.224.33.161]:1261 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264514AbTE1FQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:16:27 -0400
Date: Tue, 27 May 2003 22:29:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at include/linux/blkdev (2.5.70)
Message-ID: <20030528052934.GS8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ivan Gyurdiev <ivg2@cornell.edu>,
	LKML <linux-kernel@vger.kernel.org>
References: <200305272323.29063.ivg2@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305272323.29063.ivg2@cornell.edu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 11:23:29PM -0400, Ivan Gyurdiev wrote:
> Out of nowhere on mozilla open (after it worked fine all afternoon):
> ------------[ cut here ]------------
> kernel BUG at include/linux/blkdev.h:408!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c02322be>]    Tainted: P  
> EFLAGS: 00010046
> EIP is at blk_queue_start_tag+0x8e/0x100

This appears to be tainted by a proprietary module. Please reproduce
without it or forward the bugreport to the originator of the module.


-- wli
