Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264985AbSKFLRV>; Wed, 6 Nov 2002 06:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbSKFLRV>; Wed, 6 Nov 2002 06:17:21 -0500
Received: from ulima.unil.ch ([130.223.144.143]:48263 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S264985AbSKFLRU>;
	Wed, 6 Nov 2002 06:17:20 -0500
Date: Wed, 6 Nov 2002 12:23:53 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Cc: linux-dvb@linuxtv.org
Subject: Re: 2.5.46: DVB don't work...
Message-ID: <20021106112353.GA22269@ulima.unil.ch>
References: <20021105163106.GA5169@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021105163106.GA5169@ulima.unil.ch>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 05:31:06PM +0100, Gregoire Favre wrote:

I have tried to compil dvb-ttpci in the kernel:

  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
drivers/built-in.o(.data+0xf6f4): undefined reference to `local symbols in discarded section .exit.text'
make: *** [.tmp_vmlinux1] Error 1

Anyone got a fix?

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
