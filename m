Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267716AbTACXbh>; Fri, 3 Jan 2003 18:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267717AbTACXbg>; Fri, 3 Jan 2003 18:31:36 -0500
Received: from holomorphy.com ([66.224.33.161]:972 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267716AbTACXbf>;
	Fri, 3 Jan 2003 18:31:35 -0500
Date: Fri, 3 Jan 2003 15:39:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STUPID] Best looking code to transfer to a t-shirt
Message-ID: <20030103233927.GM29422@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301031419560.11311-100000@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301031419560.11311-100000@dns.toxicfilms.tv>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 02:25:09PM +0100, Maciej Soltysiak wrote:
> I am in a t-shirt transfering frenzy and was wondering which part of the
> kernel code it would be best to have on my t-shirt.
> I was looking at my favourite: netfilter code, but it is to clean, short
> and simple functions, no tons of pointers, no mallocs, no hex numbers, too
> many defines used. I was looking for something terribly complicated and
> looking awesome to the eye.
> How about we have a poll of the most frightening pieces of the kernel ?
> What are your ideas?

sheer bulk:			include/asm-ia64/sn/sn2/shub_mmr.h
most typedefs:			include/asm-ia64/sn/sn2/shub_mmr_t.h
bizarre (and ugly) idiom:	fs/devfs/*.c
just plain ugly:		arch/i386/kernel/cpu/mtrr/generic.c
really crusty-looking:		drivers/char/*tty*.c
terrifying ultra-legacyness:	drivers/ide/legacy/hd.c
fishiness:			drivers/usb/serial/pl2303.c
why so much code?:		drivers/char/dz.c
highly cleanup-resistant:	mm/slab.c
unusual preprocessor games:	kernel/cpufreq.c
contrived inefficiency:		fs/proc/inode.c:proc_fill_super()

Bill
