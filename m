Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130842AbRAQGTj>; Wed, 17 Jan 2001 01:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRAQGT3>; Wed, 17 Jan 2001 01:19:29 -0500
Received: from 209.102.21.2 ([209.102.21.2]:4365 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S130842AbRAQGTV>;
	Wed, 17 Jan 2001 01:19:21 -0500
Message-ID: <3A650902.7D2FA957@goingware.com>
Date: Wed, 17 Jan 2001 02:52:50 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Where to get reiserfs-utils?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

www & ftp.namesys.com seem to be down (or at least I get "no route to host) so I
can't go look there.

I get the impression that with previous patches utilities like "mkreiserfs" were
in
linux/fs/reiserfs/utils, but now that ReiserFS is in the main kernel tree the
utilities aren't there.

I've searched everywhere to find a mirror that would have a matching set of
utilities to what's in the kernel (Hans Reiser warns about the need to keep
versions in sync in his README) but I can only find older patches, no current
reiserfs-utils.

Does anyone know where there is a mirror?

Another question: I'll try it when I get the utilities, but do you know if it
should work to mount a ReiserFS filesystem using loopback from a regular file in
an Ext2 filesystem?  Yes this sounds like a silly thing to do (journaling on top
of non-journaled storage) but is a safe way to exercise the code.  I don't have
an extra partition handy to try it out on, and I don't want to use it on my real
files yet.

Thanks,

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
