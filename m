Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbQLIGzk>; Sat, 9 Dec 2000 01:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbQLIGza>; Sat, 9 Dec 2000 01:55:30 -0500
Received: from [200.222.195.208] ([200.222.195.208]:37128 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S130105AbQLIGzR>; Sat, 9 Dec 2000 01:55:17 -0500
Date: Sat, 9 Dec 2000 04:24:44 -0200
From: Frédéric L . W . Meunier 
	<0@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: SysRq behavior
Message-ID: <20001209042444.F7282@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Mailer: Mutt/1.2.5i - Linux 2.2.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't remember having the same problem months (6?) ago when
I built my first Kernel with this enabled (well, maybe I never
touched the key).

When built into the Kernel, by only pressing the
PrintScreen/SysRq the current application is terminated (tested
on a console and GNU screen). Is this just me or I should
expect it?

% calc
C-style arbitrary precision calculator (version 2.11.2t1.0)
Calc is open software. For license details type:  help
copyright
[Type "exit" to exit, or "help" for help.]

> zsh: quit

While running the application I press the key and you see the
result. It's very annoying because I accidentaly keep touching
it.

Kernel 2.2.17 on x86 (br-abnt2 keyboard, kbd 1.03). glibc 2.2,
but Kernel compiled with egcs 1.1.2.

The SysRq stuff works:

Dec  9 04:09:05 pervalidus kernel: SysRq: unRaw saK Boot Sync
Unmount showPc showTasks showMem loglevel0-8 tErm kIll killalL

-- 
0@pervalidus.{net,{dyndns.}org} TelFax: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
