Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270123AbTGSOYf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 10:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270130AbTGSOYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 10:24:34 -0400
Received: from www.13thfloor.at ([212.16.59.250]:43220 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S270123AbTGSOYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 10:24:32 -0400
Date: Sat, 19 Jul 2003 16:39:36 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: NFS root and Floppy Fallback Issues ...
Message-ID: <20030719143936.GA904@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo!
Hi Trond!

kernel 2.4.22-pre7 with

CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
CONFIG_BLK_DEV_FD=y

and boot options:   "root=/dev/marcelo ro"

-------------------------------------------------
Root-NFS: No NFS server available, giving up.                                    
VFS: Unable to mount root fs via NFS, trying floppy.                             
VFS: Insert root floppy and press ENTER                      			 

...

do I need to say more?

best,
Herbert

PS: still waiting for a really good explanation,
    why the fix and the patches are not welcome.


