Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283615AbRK3LV4>; Fri, 30 Nov 2001 06:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283616AbRK3LVq>; Fri, 30 Nov 2001 06:21:46 -0500
Received: from web11402.mail.yahoo.com ([216.136.131.232]:14453 "HELO
	web11402.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283615AbRK3LVh>; Fri, 30 Nov 2001 06:21:37 -0500
Message-ID: <20011130112136.79271.qmail@web11402.mail.yahoo.com>
Date: Fri, 30 Nov 2001 03:21:36 -0800 (PST)
From: Abhishek Rai <abbashake007@yahoo.com>
Subject: File system
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here are my problems :
1.
i implemented a file system on redhat linux 6.2 named
it pfs(peaceful file system). inserted it as a module
using insmod. got inserted peacefully.  the fs worked
on linux 6.2 :mouunted, ls, cat ,etc. .... But
consider the following problem:
	i unmount the dev i had mounted as a pfs file system.
then i try to rmmod the pfs module :
what i get is:
pfs: Device or resource busy.

i tried similar stuff with minix, ensured that the
module functionality of pfs, the include files of pfs
is identical to minix. 
STILL THE SAME TROUBLE.
	
2.
i compile this code on redhat 7.2 :   compiled ok
(after 
(i):-i made necessary changes in some functions which
had witnessed a change in their definitions, etc..
anyway fugget it
(ii):-got some directions while compiling regarding
the compile time options : tried them and things got
ok
). 
then i try to do insmod: result ...  i get many
functions as unresolved symbol. i check for the same
functions in ext3fs(which is added as a module to the
7.2's kernel).. i find the "unresolved" functions up
and working fine for ext3fs. i make sure that my
includes etc. are identical to ext3fs's : no use. 
i bang my head : no use.
so why this problem

-abhishek

=====
Don't say Goodbye say Goodluck
============================================================
Abhishek Rai
3rd year,B.Tech, Computer Science and Engineering
IIT KGP,India
abbashake007@yahoo.com
============================================================


__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
