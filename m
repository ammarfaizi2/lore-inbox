Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUDODKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 23:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUDODKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 23:10:44 -0400
Received: from main.gmane.org ([80.91.224.249]:32137 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263555AbUDODKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 23:10:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Hubert Chan <hubert@uhoreg.ca>
Subject: Re: [PATCH] reiserfs v3 fixes and features
Date: Wed, 14 Apr 2004 22:53:16 -0400
Message-ID: <874qrmkl43.fsf@uhoreg.ca>
References: <1081274618.30828.30.camel@watt.suse.com> <1081989006.27614.110.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe0004e289e618-cm.cpe.net.cable.rogers.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:H63jkVkKZ9FGCYJH8SRxjsxKn7g=
Cc: reiserfs-list@namesys.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.5, it still fails:

...
  CC      fs/reiserfs/bitmap.o
In file included from fs/reiserfs/bitmap.c:8:
include/linux/reiserfs_fs.h: In function `reiserfs_transaction_running':
include/linux/reiserfs_fs.h:1752: error: structure has no member named `journal_info'
make[3]: *** [fs/reiserfs/bitmap.o] Error 1
make[2]: *** [fs/reiserfs] Error 2
make[1]: *** [fs] Error 2

(all patches applied, except for reiserfs-group-alloc-8 and
reiserfs-search_reada-5)

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

