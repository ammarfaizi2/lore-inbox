Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261975AbREPPGA>; Wed, 16 May 2001 11:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261976AbREPPFu>; Wed, 16 May 2001 11:05:50 -0400
Received: from web13703.mail.yahoo.com ([216.136.175.136]:22035 "HELO
	web13703.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261975AbREPPFk>; Wed, 16 May 2001 11:05:40 -0400
Message-ID: <20010516150538.20451.qmail@web13703.mail.yahoo.com>
Date: Wed, 16 May 2001 08:05:38 -0700 (PDT)
From: siva prasad <si_pras@yahoo.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the newbie question..

Is it true that the ipc calls like
msgget(),shmget()...
are  not really system calls?

Cos in the file "asm/unistd.h" where the
system calls are listed as __NR_xxx we dont find
the appropriate listing for the ipc calls.
What I guessed was that all the ipc calls are
clubbed under the 'int ipc()' system call and this
is well listed in the "asm/unistd.h" 

Could some one explain why the ipc is implemented 
this way rather that implementing them as individual 
system calls as in UNIX.

Or is it the same way in UNIX




__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
