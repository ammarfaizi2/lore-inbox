Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbTBKPXL>; Tue, 11 Feb 2003 10:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTBKPXK>; Tue, 11 Feb 2003 10:23:10 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:56995 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S261463AbTBKPXJ>;
	Tue, 11 Feb 2003 10:23:09 -0500
Date: Tue, 11 Feb 2003 16:32:48 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: "Marco C. Mason" <mason@ntr.net>
cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       "Theodore Ts'o" <tytso@mit.edu>, peter@chubb.wattle.id.au,
       bernard@biesterbos.nl
Subject: Re:2TB+ fs ext3 (was fsck out of memory)
In-Reply-To: <3E486596.2090800@ntr.net>
Message-ID: <Pine.LNX.4.53.0302111628230.15933@ddx.a2000.nu>
References: <3E486596.2090800@ntr.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Marco C. Mason wrote:
> I don't know if anyone mentioned it or not, but the block addresses in your
> error messages appear suspiciously close to 2^29.  I'm suspecting an
> internal
> overflow in a calculation somewhere...

615381536 blocks can this be over the limit ?

(-b 8192 gives me warning : 'Warning: blocksize 8192 not usable on most
systems.')
