Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbSJPJcI>; Wed, 16 Oct 2002 05:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSJPJcI>; Wed, 16 Oct 2002 05:32:08 -0400
Received: from mail.hometree.net ([212.34.181.120]:4577 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S264975AbSJPJcH>; Wed, 16 Oct 2002 05:32:07 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH 2/3] Add extended attributes to ext2/3
Date: Wed, 16 Oct 2002 09:38:02 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aojc1q$l37$1@forge.intermeta.de>
References: <E181a3S-0006Nq-00@snap.thunk.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1034761082 25066 212.34.181.4 (16 Oct 2002 09:38:02 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 16 Oct 2002 09:38:02 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu writes:

>+	int ea_blocks = EXT3_I(inode)->i_file_acl ?
>+		(inode->i_sb->s_blocksize >> 9) : 0;

Sometimes I wonder if we shouldn't have the block size (512) and the
bit shift (9) as defines somewhere and gradually shift away from hard
coded values...

If we ever decide to change the block size of ext2/ext3, we're in for
a "looking for nines"... :-)

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
