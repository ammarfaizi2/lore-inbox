Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265806AbUA1Ifj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 03:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUA1Ifj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 03:35:39 -0500
Received: from cc15467-a.groni1.gr.home.nl ([217.120.147.78]:34750 "HELO
	boetes.org") by vger.kernel.org with SMTP id S265806AbUA1Ifh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 03:35:37 -0500
Date: Wed, 28 Jan 2004 09:36:23 +0100
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm1
Message-ID: <20040128083645.GI2650@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040127233402.6f5d3497.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127233402.6f5d3497.akpm@osdl.org>
X-GPG-Key: http://www.xs4all.nl/~hanb/keys/Han_pubkey.gpg
X-GPG-Fingerprint: EB66 D194 AB3F 4C57 49EF 6795 44AE E0D8 3F38 7301
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmmm my build breaks with:

  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.init.text+0x1342): In function `setup_memory':
: undefined reference to `find_smp_config'
arch/i386/kernel/built-in.o(.entry.text+0xb11): In function `vic_sys_interrupt':
: undefined reference to `smp_vic_sys_interrupt'
arch/i386/kernel/built-in.o(.entry.text+0xb35): In function `vic_cmn_interrupt':
: undefined reference to `smp_vic_cmn_interrupt'
arch/i386/kernel/built-in.o(.entry.text+0xb59): In function `vic_cpi_interrupt':
: undefined reference to `smp_vic_cpi_interrupt'
arch/i386/kernel/built-in.o(.entry.text+0xb7d): In function `qic_timer_interrupt':
: undefined reference to `smp_qic_timer_interrupt'
arch/i386/kernel/built-in.o(.entry.text+0xba1): In function `qic_invalidate_interrupt':
: undefined reference to `smp_qic_invalidate_interrupt'
arch/i386/kernel/built-in.o(.entry.text+0xbc5): In function `qic_reschedule_interrupt':
: undefined reference to `smp_qic_reschedule_interrupt'
arch/i386/kernel/built-in.o(.entry.text+0xbe9): In function `qic_enable_irq_interrupt':
: undefined reference to `smp_qic_enable_irq_interrupt'
arch/i386/kernel/built-in.o(.entry.text+0xc0d): In function `qic_call_function_interrupt':
: undefined reference to `smp_qic_call_function_interrupt'
arch/i386/mach-voyager/built-in.o(.text+0x1bd): In function `voyager_power_off':
: undefined reference to `voyager_cat_power_off'
arch/i386/mach-voyager/built-in.o(.text+0x3e6): In function `check_from_kernel':
: undefined reference to `voyager_status'
arch/i386/mach-voyager/built-in.o(.text+0x425): In function `check_continuing_condition':
: undefined reference to `voyager_status'
arch/i386/mach-voyager/built-in.o(.text+0x448): In function `check_continuing_condition':
: undefined reference to `voyager_cat_psi'
arch/i386/mach-voyager/built-in.o(.text+0x523): In function `thread':
: undefined reference to `voyager_status'
arch/i386/mach-voyager/built-in.o(.text+0x56b): In function `thread':
: undefined reference to `voyager_status'



# Han
