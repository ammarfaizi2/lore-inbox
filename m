Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbRB1Brh>; Tue, 27 Feb 2001 20:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130045AbRB1Br1>; Tue, 27 Feb 2001 20:47:27 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:64539 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129723AbRB1BrS>; Tue, 27 Feb 2001 20:47:18 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Sergey Kubushin" <ksi@cyberbills.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac6 
In-Reply-To: Your message of "Tue, 27 Feb 2001 16:54:28 -0800."
             <Pine.LNX.4.31ksi3.0102271652140.15248-100000@nomad.cyberbills.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Feb 2001 12:47:12 +1100
Message-ID: <7784.983324832@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001 16:54:28 -0800 (PST), 
"Sergey Kubushin" <ksi@cyberbills.com> wrote:
>Menuconfig doesn't work. Worked fine in 2.4.2-ac5.

Against 2.4.2-ac6.

Index: 2.9/arch/i386/config.in
--- 2.9/arch/i386/config.in Wed, 28 Feb 2001 12:44:01 +1100 kaos (linux-2.4/T/c/36_config.in 1.1.2.1.1.2 644)
+++ 2.9(w)/arch/i386/config.in Wed, 28 Feb 2001 12:46:03 +1100 kaos (linux-2.4/T/c/36_config.in 1.1.2.1.1.2 644)
@@ -379,6 +379,6 @@ bool '  Memory mapped I/O debugging' CON
 bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
 bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
-endmenu
-
 fi
+
+endmenu

