Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264902AbUGMLNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUGMLNf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 07:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbUGMLNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 07:13:34 -0400
Received: from holomorphy.com ([207.189.100.168]:40084 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264656AbUGMLNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 07:13:20 -0400
Date: Tue, 13 Jul 2004 04:13:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lenar L?hmus <lenar@vision.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Preempt Threshold Measurements
Message-ID: <20040713111314.GX21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Lenar L?hmus <lenar@vision.ee>, linux-kernel@vger.kernel.org
References: <200407121943.25196.devenyga@mcmaster.ca> <20040713024051.GQ21066@holomorphy.com> <200407122248.50377.devenyga@mcmaster.ca> <cone.1089687290.911943.12958.502@pc.kolivas.org> <20040712210107.1945ac34.akpm@osdl.org> <20040713100815.GU21066@holomorphy.com> <20040713104059.GW21066@holomorphy.com> <40F3C28C.5070701@vision.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F3C28C.5070701@vision.ee>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 02:07:56PM +0300, Lenar L?hmus wrote:
> With all those little patches added and 2.6.8-rc1-ck5 I got this in
> my dmesg (preempt=0 voluntary=1 if it makes difference):
> bad: ld(3362) scheduling while atomic (1)!
> [<c02797ff>] schedule+0x43f/0x480
> [<c01161a3>] kmap_atomic+0x13/0x70
> [<c0117b5b>] __touch_preempt_timing+0xb/0x30
> [<c0146ef7>] shmem_file_write+0x2f7/0x320
> [<c014d890>] vfs_write+0xb0/0x100
> [<c014d978>] sys_write+0x38/0x60
> [<c0103ee1>] sysenter_past_esp+0x52/0x71
> bad: krootimage(3483) scheduling while atomic (1)!
> [<c02797ff>] schedule+0x43f/0x480
> [<c01161a3>] kmap_atomic+0x13/0x70
> [<c0117b5b>] __touch_preempt_timing+0xb/0x30
> [<c0146ef7>] shmem_file_write+0x2f7/0x320
> [<c014d890>] vfs_write+0xb0/0x100
> [<c014d978>] sys_write+0x38/0x60
> [<c0103ee1>] sysenter_past_esp+0x52/0x71

Amazing. I'll get a coherent patch out vs. 2.6.8-rc1 and so on.

-- wli
