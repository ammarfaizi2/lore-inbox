Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282185AbRKWQxp>; Fri, 23 Nov 2001 11:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282188AbRKWQxf>; Fri, 23 Nov 2001 11:53:35 -0500
Received: from [213.37.2.159] ([213.37.2.159]:6055 "EHLO alcorcon.madritel.es")
	by vger.kernel.org with ESMTP id <S282185AbRKWQxZ>;
	Fri, 23 Nov 2001 11:53:25 -0500
To: linux-kernel@vger.kernel.org
Subject: Moving ext3 journal file
Message-Id: <E167Fuw-00001K-00@DervishD>
Date: Fri, 23 Nov 2001 13:58:54 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <dervishd@jazzfree.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <dervishd@jazzfree.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello all :))

    Is there any problem on moving the /.journal file (even renaming
it) so it doesn't lives on the root? I mean, maintaining its inode
number, of course ;))

    Anyway, ext3 shouldn't (just an idea) show the journal as a
normal file. It may add some load on the kernel, because the inode
number should be compared with that of the journal every time a file
is accessed, but it's just a suggestion ;))

    And, BTW, ext3 works *really* great :))))

    Raúl
