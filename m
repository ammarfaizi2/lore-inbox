Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbRELSnm>; Sat, 12 May 2001 14:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbRELSnc>; Sat, 12 May 2001 14:43:32 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:12805 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S261312AbRELSnT>;
	Sat, 12 May 2001 14:43:19 -0400
Message-ID: <3AFD8577.43DA8403@megapathdsl.net>
Date: Sat, 12 May 2001 11:48:23 -0700
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.4.4-ac[6-8] -- ssh failing with -1 ESPIPE (Illegal seek) errors.
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure how far back this has been broken.
I am attempting to do a cvs update of the XFree86 tree
with CVS_RSH set to ssh1.

old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40015000
_llseek(4, 0, 0xbffff9a4, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
fcntl(5, F_GETFL)                       = 0 (flags O_RDONLY)
fstat64(0x5, 0xbffff958)                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40016000
_llseek(5, 0, 0xbffff998, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
brk(0x80e7000)                          = 0x80e7000
write(4, "Root /cvs\nValid-responses ok err"..., 367) = 367
read(5, 

Am I doing something wrong or is this fallout from the recent
network changes in the development tree?

Thanks,
	Miles
