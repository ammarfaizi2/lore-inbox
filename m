Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTE1Ffw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTE1Ffv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:35:51 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:52098
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264533AbTE1Ffu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:35:50 -0400
Date: Wed, 28 May 2003 01:38:35 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Ivan Gyurdiev <ivg2@cornell.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at include/linux/blkdev (2.5.70)
In-Reply-To: <20030528052934.GS8978@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0305280130160.15323-100000@montezuma.mastecende.com>
References: <200305272323.29063.ivg2@cornell.edu> <20030528052934.GS8978@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, William Lee Irwin III wrote:

> On Tue, May 27, 2003 at 11:23:29PM -0400, Ivan Gyurdiev wrote:
> > Out of nowhere on mozilla open (after it worked fine all afternoon):
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/blkdev.h:408!
> > invalid operand: 0000 [#1]
> > CPU:    0
> > EIP:    0060:[<c02322be>]    Tainted: P  
> > EFLAGS: 00010046
> > EIP is at blk_queue_start_tag+0x8e/0x100
> 
> This appears to be tainted by a proprietary module. Please reproduce
> without it or forward the bugreport to the originator of the module.

Looks valid;

We tried to remove the previous request.. but there was none. The BUG 
check looks odd (what happens to the first tag?)

	Zwane
-- 
function.linuxpower.ca
