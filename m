Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbRAaGaB>; Wed, 31 Jan 2001 01:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbRAaG3w>; Wed, 31 Jan 2001 01:29:52 -0500
Received: from ladyluck.clue4all.net ([130.215.241.207]:10376 "EHLO
	ladyluck.clue4all.net") by vger.kernel.org with ESMTP
	id <S129860AbRAaG3j>; Wed, 31 Jan 2001 01:29:39 -0500
Message-ID: <3A77B0CE.74C0F8BF@clue4all.net>
Date: Wed, 31 Jan 2001 01:29:34 -0500
From: "Brian J. Conway" <dogbert@clue4all.net>
Organization: Clue 4 All, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: chaffee@bmrc.cs.berkeley.edu
CC: linux-kernel@vger.kernel.org
Subject: VFAT access times in 2.4.1 kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I just switched to 2.4.1 from 2.2.18 and have the kernel set up
in generally the same manner in terms of functionality.  I've found that
VFAT access is incredibly slow in directories with a large number of
files.  I have a single directory with approximately 1500 items, all
3-5MB apiece, and if I do 'ls -alt dir/ |more' on that directory, it
takes a full 2 seconds do list the contents of the first page.  If I do
so again immediately afterwards it displays immediately, but the same
effects occur if I wait any considerable amount of time (> 2 minutes). 
I've experienced no such problems under 2.2.18, and I'm running a 20GB
Maxtor drive running at UDMA(33) without any known issues.  Any ideas?

Brian J. Conway
dogbert@clue4all.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
