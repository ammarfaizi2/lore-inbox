Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVGLRyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVGLRyV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVGLRyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:54:08 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:46222 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261827AbVGLRxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:53:39 -0400
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: synaptics touchpad not recognized by Xorg X server with recent -mm kernels
References: <20050712172504.GD24820@gamma.logic.tuwien.ac.at>
From: Peter Osterlund <petero2@telia.com>
Date: 12 Jul 2005 19:52:48 +0200
In-Reply-To: <20050712172504.GD24820@gamma.logic.tuwien.ac.at>
Message-ID: <m3fyujq5cf.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> writes:

> Hello Peter, hi Andrew!
> 
> Since 2.6.13-rc2-mm1 my X does not find my synaptics touchpad driver.
> 
> With kernel 2.6.13-rc2-mm2 (same with rc2-mm1) I get from the kernel:
> 
> Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713/0x4006
> input: SynPS/2 Synaptics TouchPad on isa0060/serio1
> 
> and Xorg.0.log gives:
> 
> (II) Synaptics touchpad driver version 0.14.2
> touchpad no synaptics event device found (checked 10 nodes)
> touchpad The evdev kernel module seems to be missing

What's the output from "cat /proc/bus/input/devices"?

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
