Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265155AbRF0AC5>; Tue, 26 Jun 2001 20:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265157AbRF0ACs>; Tue, 26 Jun 2001 20:02:48 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:4623 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S265155AbRF0ACe>;
	Tue, 26 Jun 2001 20:02:34 -0400
Message-ID: <20010627020237.A24622@win.tue.nl>
Date: Wed, 27 Jun 2001 02:02:37 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Kenneth Johansson <ken@canit.se>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT2 Filesystem permissions (bug)?
In-Reply-To: <m28zigi7m4.fsf@boreas.yi.org.> <Pine.LNX.4.30.0106251729450.18996-100000@coredump.sh0n.net> <9h8b8q$s95$1@cesium.transmeta.com> <3B390B48.D444B7C5@canit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3B390B48.D444B7C5@canit.se>; from Kenneth Johansson on Wed, Jun 27, 2001 at 12:23:04AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:

:: It's neither a bug nor undocumented.

Kenneth Johansson wrote:

: Interesting but I wonder how much this helps someone that not already know
: what it is. Should not the ls manual also contain something that explains

In fact the best info is on the stat page:

...
       The set GID bit (S_ISGID) has several special uses: For  a
       directory  it  indicates  that BSD semantics is to be used
       for that directory:  files  created  there  inherit  their
       group ID from the directory, not from the effective gid of
       the creating process, and directories created  there  will
       also  get  the  S_ISGID bit set.  For a file that does not
       have the group execution bit (S_IXGRP) set,  it  indicates
       mandatory file/record locking.

       The  `sticky'  bit  (S_ISVTX)  on a directory means that a
       file in that directory can be renamed or deleted  only  by
       the  owner of the file, by the owner of the directory, and
       by root.
...
