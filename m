Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSJ2Rjf>; Tue, 29 Oct 2002 12:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJ2Rjf>; Tue, 29 Oct 2002 12:39:35 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:12303 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262326AbSJ2Rje>; Tue, 29 Oct 2002 12:39:34 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15806.51536.985203.709475@laputa.namesys.com>
Date: Tue, 29 Oct 2002 20:45:52 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: [ANNOUNCE]: reiser4
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Emacs-Acronym: Emacs Manuals Always Cause Senility
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Snapshot of reiser4 source code can be found at 
http://www.namesys.com/snapshots/2002.10.29/.

It is set of patches against current Linus BK tree (2.5.44).

Reiser4 is the next version of ReiserFS file system. It was re-written
from the scratch. It supports:

 - full data journalling with "wandered logs" ("shadows" in DB
   parlance);

 - extent-based files;

 - delayed allocation of disk space and on-line optimization of disk
   layout across file boundaries;

 - plugins: infrastructure for easy extention of file system and utils
   functionality;

 - and a lot more, see http://www.namesys.com/v4/v4.html

Snapshot contains reiser4 proper (fs_reiser4.diff), set of patches
(described in READ.ME) with necessary changes to the core kernel, and
utils package (in particlar, mkfs.reiser4).

It is still crasheable. Do not put critical data on it.

Nikita.
