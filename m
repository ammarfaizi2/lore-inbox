Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAXK7z>; Wed, 24 Jan 2001 05:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbRAXK7q>; Wed, 24 Jan 2001 05:59:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:42757 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129511AbRAXK7m>; Wed, 24 Jan 2001 05:59:42 -0500
Date: Wed, 24 Jan 2001 07:09:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: V Ganesh <ganesh@veritas.com>
cc: linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: inode->i_dirty_buffers redundant ?
In-Reply-To: <200101240955.PAA28367@vxindia.veritas.com>
Message-ID: <Pine.LNX.4.21.0101240656170.10272-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jan 2001, V Ganesh wrote:

> now that we have inode->i_mapping->dirty_pages, what do we need
> inode->i_dirty_buffers for ? I understand the latter was added for the O_SYNC
> changes before dirty_pages came into the picture. but now both seem to be
> doing more or less the same thing.

inode->i_mapping->dirty_pages contains only mapped data pages of the
inode, not metadata.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
