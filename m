Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267326AbTACAG4>; Thu, 2 Jan 2003 19:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbTACAG4>; Thu, 2 Jan 2003 19:06:56 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:54701 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S267326AbTACAGz>;
	Thu, 2 Jan 2003 19:06:55 -0500
Date: Fri, 3 Jan 2003 01:15:22 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: __NR_exit_group for 2.4-O(1)
Message-ID: <20030103001522.GA1539@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I am running glibc-2.3.1 on top of a hacked 2.4.21-pre2+aa, and all programs
show a curious message at exit when straced:

strace ls:
...
SYS_252(0, 0x1000, 0x156ad360, 0x156ae824, 0) = -1 ENOSYS (Function not implemented)
_exit(0)                                = ?

252 is __NR_exit_group. I can not recover anything about this on MARC, is there
any pointer to that for 2.4 ? Is it in -ac kernels ?

BTW: I remember to see some posts about this, but _how_ can I make the search
engine in MARC to do _not_ convert underscores to spaces ("exit_group" ->
"exit group", and results not be half the posts in LKML) ???

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
