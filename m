Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318751AbSH1IAg>; Wed, 28 Aug 2002 04:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318760AbSH1IAg>; Wed, 28 Aug 2002 04:00:36 -0400
Received: from d136-ps2-mel.alphalink.com.au ([202.161.107.136]:10369 "HELO
	spunk.spunk") by vger.kernel.org with SMTP id <S318751AbSH1IAf>;
	Wed, 28 Aug 2002 04:00:35 -0400
Date: Wed, 28 Aug 2002 18:14:12 +1000
From: Edward Coffey <ecoffey@alphalink.com.au>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.32
Message-ID: <20020828081412.GA1496@spunk>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make modules_install finishes up with a few unresolved symbols:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.32; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.32/kernel/arch/i386/kernel/apm.o
depmod:         cpu_gdt_table
depmod: *** Unresolved symbols in /lib/modules/2.5.32/kernel/drivers/input/evdev.o
depmod:         input_devclass
depmod: *** Unresolved symbols in /lib/modules/2.5.32/kernel/drivers/input/mousedev.o
depmod:         input_devclass
depmod: *** Unresolved symbols in /lib/modules/2.5.32/kernel/sound/core/snd.o
depmod:         devfs_find_and_unregister
