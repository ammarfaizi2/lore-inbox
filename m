Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbTIKCIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 22:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTIKCIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 22:08:11 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:34689
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261815AbTIKCIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 22:08:11 -0400
Date: Wed, 10 Sep 2003 22:07:58 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Maciej <maciej@apathy.killer-robot.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] i386 /proc/irq/.../smp_affinity
In-Reply-To: <20030911020218.GQ4306@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0309102206300.5403@montezuma.fsmlabs.com>
References: <20030910191459.GA12099@apathy.black-flower>
 <Pine.LNX.4.53.0309101535050.9323@montezuma.fsmlabs.com>
 <20030911020218.GQ4306@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, William Lee Irwin III wrote:

> This backs out the variable-length cpu bitmask handling.
> 
> I appear to be printing out 16-bit chunks of all this in what appears
> to be the reverse of the order expected. Why not just reverse the order
> of the 16-bit chunks?

Indeed it does, i was thinking about supported systems and the lack of 
NR_CPUS > BITS_PER_LONG ia32 boxen.
