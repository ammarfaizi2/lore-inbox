Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSD0Tk2>; Sat, 27 Apr 2002 15:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314420AbSD0Tk1>; Sat, 27 Apr 2002 15:40:27 -0400
Received: from newman.edw2.uc.edu ([129.137.2.198]:49417 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S314422AbSD0Tk1>;
	Sat, 27 Apr 2002 15:40:27 -0400
From: kuebelr@email.uc.edu
Date: Sat, 27 Apr 2002 15:40:19 -0400
To: linux-kernel@vger.kernel.org
Subject: un-removable files on reiserfs
Message-Id: <20020427194019.GA898@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have a few files on a reiserfs disk that i cannot remove. they showed
up sometime after i started using 2.4.17.  also, i haven't been able to
find an oops in my ksymoops logs.

i also have used 2.4.18 and 2.4.19-pre2 for a day or two each.

here is an example: /non-debian/src/openbsd/sys/arch/sun3/stand/CVS/nn

% ls -l /non-debian/src/openbsd/sys/arch/sun3/stand/CVS
ls: /non-debian/src/openbsd/sys/arch/sun3/stand/CVS/nn: No such file or directory
total 8
-rw-r--r--    1 rob      rob           211 Oct 17  2001 Entries
-rw-r--r--    1 rob      rob            24 Oct 17  2001 Repository

% ls -l /non-debian/src/openbsd/sys/arch/sun3/stand/CVS/nn
ls: /non-debian/src/openbsd/sys/arch/sun3/stand/CVS/nn: No such file or directory

% ls -ld /non-debian/src/openbsd/sys/arch/sun3/stand/CVS
drwxr-xr-x    2 rob      rob           104 Oct 19  2001 /non-debian/src/openbsd/sys/arch/sun3/stand/CVS

i can provide any other info, if needed.

thanks.
rob.

