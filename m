Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADWk0>; Thu, 4 Jan 2001 17:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRADWkR>; Thu, 4 Jan 2001 17:40:17 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:11526 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129267AbRADWkI>; Thu, 4 Jan 2001 17:40:08 -0500
Date: Thu, 4 Jan 2001 18:48:13 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alexander Viro <viro@math.psu.edu>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: -bird tree Re: [Ext2-devel] Re: [RFC] ext2_new_block() behaviour
In-Reply-To: <Pine.GSO.4.21.0101041721531.20875-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0101041844500.1453-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Jan 2001, Alexander Viro wrote:

<snip>

> Al, putting together fs patches for -bird...

Al, 

Have you added Chris Mason patch to SetPageDirty in mark_buffer_dirty() &
related changes to your -bird tree ? 

Also, would you accept a patch to remove mark_buffer_dirty() (and use
__mark_buffer_dirty() and balance_dirty only after unlock_super()) from
places with superblock lock held in ext2? 





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
