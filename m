Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279811AbRJaCLN>; Tue, 30 Oct 2001 21:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279827AbRJaCKy>; Tue, 30 Oct 2001 21:10:54 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:32248
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279811AbRJaCKw>; Tue, 30 Oct 2001 21:10:52 -0500
Date: Tue, 30 Oct 2001 18:11:24 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Cached accounting problem [was: funny free output with all mem for buffers]
Message-ID: <20011030181124.I490@mikef-linux.matchmail.com>
Mail-Followup-To: "J . A . Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011030192919.A2436@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011030192919.A2436@werewolf.able.es>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 07:29:19PM +0100, J . A . Magallon wrote:
> Hi.
> 
> When making several images of Linux install disks with dd
> (dd if=/dev/cdrom of=linux.img) I dared to check the mem/cache state:
> 
>              total       used       free     shared    buffers     cached
> Mem:        513168     510104       3064        992     349720 4294707520
> -/+ buffers/cache: -4294547136 4295060304
> Swap:       345356          0     345356
> 

I have this too on my
vmlinuz-2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap 
kernel

The previous kernel,
vmlinuz-2.4.12-ac5+acct-entropy+preempt+netdev-ramdom+vm-free-swapcache
didn't do this.

Has anyone seen this with 2.4.13-ac4?
