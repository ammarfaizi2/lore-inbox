Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbTGDIOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265857AbTGDIOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:14:19 -0400
Received: from WebDev.iNES.RO ([80.86.100.174]:60820 "EHLO webdev.ines.ro")
	by vger.kernel.org with ESMTP id S265856AbTGDIOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:14:09 -0400
Date: Fri, 4 Jul 2003 11:28:34 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: linux-kernel@vger.kernel.org
Subject: ext3 error
Message-ID: <Pine.LNX.4.56L0.0307041121360.21426@webdev.ines.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found these errors in the logs while running 2.5.74-mm1:

EXT3-fs warning (device hda3): ext3_unlink: Deleting nonexistent file 
(608857), 0
EXT3-fs warning (device hda3): ext3_unlink: Deleting nonexistent file 
(626408), 0
EXT3-fs warning (device hda3): ext3_unlink: Deleting nonexistent file 
(579055), 0
EXT3-fs error (device hda3): ext3_delete_entry: bad entry in directory 
#657519: inode out of bounds - offset=824, inode=375560
8452, rec_len=20, name_len=9
Remounting filesystem read-only
EXT3-fs error (device hda3) in start_transaction: Readonly filesystem
EXT3-fs error (device hda3): ext3_find_entry: bad entry in directory 
#657519: inode out of bounds - offset=824, inode=37556084
52, rec_len=20, name_len=9

