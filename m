Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUDOMOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 08:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbUDOMOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 08:14:21 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:22700 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263000AbUDOMOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 08:14:19 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16510.31796.137286.428042@laputa.namesys.com>
Date: Thu, 15 Apr 2004 16:12:36 +0400
To: Hubert Chan <hubert@uhoreg.ca>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs v3 fixes and features
In-Reply-To: <874qrmkl43.fsf@uhoreg.ca>
References: <1081274618.30828.30.camel@watt.suse.com>
	<1081989006.27614.110.camel@watt.suse.com>
	<874qrmkl43.fsf@uhoreg.ca>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan writes:
 > On 2.6.5, it still fails:
 > 
 > ...
 >   CC      fs/reiserfs/bitmap.o
 > In file included from fs/reiserfs/bitmap.c:8:
 > include/linux/reiserfs_fs.h: In function `reiserfs_transaction_running':
 > include/linux/reiserfs_fs.h:1752: error: structure has no member named `journal_info'
 > make[3]: *** [fs/reiserfs/bitmap.o] Error 1

Err.. clash with the reiser4 patch, surely.

 > make[2]: *** [fs/reiserfs] Error 2
 > make[1]: *** [fs] Error 2
 > 
 > (all patches applied, except for reiserfs-group-alloc-8 and
 > reiserfs-search_reada-5)

Nikita.

 > 
 > -- 
 > Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
 > PGP/GnuPG key: 1024D/124B61FA
 > Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
 > Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.
 > 
