Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132352AbRDWWHm>; Mon, 23 Apr 2001 18:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132370AbRDWWHX>; Mon, 23 Apr 2001 18:07:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:36275 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132352AbRDWWHK>;
	Mon, 23 Apr 2001 18:07:10 -0400
Date: Mon, 23 Apr 2001 18:07:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Subject: [CFT][PATCH] namespaces patch (2.4.4-pre6)
In-Reply-To: <Pine.GSO.4.21.0103290545060.29330-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0104231758300.4968-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 	Folks, updated namespace patch is on
ftp.math.psu.edu/pub/viro/namespaces-c-S4-pre6.gz
 
News:
	* ported to 2.4.4-pre6
	* fixes for d_flags races (already in -ac, hopefully will go into
the main tree soon)
	* fixes for sync_inodes()/kill_super() races (submitted to Linus
and Alan, hopefully will go into the tree soon)
	* killed low-memory deadlocks between {u,re,}mount and kswapd.
	* further cleanup of fs/super.c

It works here. Please, help with testing. Patch had somewhat grown, but
new pieces are fixes for the bugs present in the main tree and these
fixes had been submitted for inclusion in 2.4, so hopefully it will
shrink again.
 							Cheers,
 								Al

