Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132031AbRASSY6>; Fri, 19 Jan 2001 13:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135473AbRASSYs>; Fri, 19 Jan 2001 13:24:48 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:53512 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S132031AbRASSYj>; Fri, 19 Jan 2001 13:24:39 -0500
Message-ID: <3A68B126.7C5B6262@mail.infotel.ru>
Date: Fri, 19 Jan 2001 21:27:02 +0000
From: Edward <edward@mail.infotel.ru>
Reply-To: edward@namesys.com
Organization: Namesys
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
CC: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Don't mix reiserfs and RAID5 in linux-2.4.1-pre8, severe corruption
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reiserfs in linux-2.4.1-pre8 does not properly with the RAID5 code that
is in that kernel.  It is easy to get corrupted filesystem on device in
less than 1 minute. Please, do not use it (reiserfs) on RAID5 devices.
We are trying to figure out what is wrong.

Edward
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
