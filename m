Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278639AbRKKQxu>; Sun, 11 Nov 2001 11:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279382AbRKKQxa>; Sun, 11 Nov 2001 11:53:30 -0500
Received: from [213.228.128.57] ([213.228.128.57]:39878 "HELO
	front2.netvisao.pt") by vger.kernel.org with SMTP
	id <S279061AbRKKQxZ>; Sun, 11 Nov 2001 11:53:25 -0500
To: linux-kernel@vger.kernel.org
Subject: Compiling manually
From: pocm@rnl.ist.utl.pt (Paulo J. Matos aka PDestroy)
Date: 11 Nov 2001 16:57:41 +0000
Message-ID: <m3k7wxkzy2.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to compile kernel 2.4.14.
The problem is that the famous gcc 3.0.x bug of giving error when
trying to compile 8139too.c is getting me crazy.
The work around is to remove -O2 optimization.
How can I compile the kernel with optimization except
optimization for that particular file?
I've tried to compile it as usual. Then I got an error in
8139too.c  and I manually compile the file into an object file
without optimization and I though make would see the file
compiled and it'd not try again but I was wrong. As soon as I
tried to compile the kernel with make bzImage it started to pass
all files already compiled but when it entered drivers/net the
first thing it did was to compile the 8139too.c file with
optimization and I'm stuck.
How can I remove optimization from that file only or maybe
compile the file manually and then don't let make compile the
file again?

Best regards,

Paulo
 
-- 
Paulo J. Matos aka PDestroy : pocm(_at_)rnl.ist.utl.pt
Instituto Superior Tecnico - Lisbon
Software & Computer Engineering - A.I.
 - > http://www.rnl.ist.utl.pt/~pocm

