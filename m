Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289384AbSAVVbt>; Tue, 22 Jan 2002 16:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289316AbSAVVbk>; Tue, 22 Jan 2002 16:31:40 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:17422 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289381AbSAVVb0>;
	Tue, 22 Jan 2002 16:31:26 -0500
Date: Tue, 22 Jan 2002 19:31:10 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Hans Reiser <reiser@namesys.com>, Chris Mason <mason@suse.com>,
        Andreas Dilger <adilger@turbolabs.com>, <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <1011734932.271.1.camel@unaropia>
Message-ID: <Pine.LNX.4.33L.0201221930360.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2002, Shawn Starr wrote:

> I've started on writing a pagebuf daemon (experimenting with ramfs).
> It will have the VM manage the allocating/freeing of pages. The
> filesystem should not have to know when a page needs to be freed or
> allocated. It just need pages. The pagebuf is supposed to age pages
> not the filesystem.

Last I looked it was try_to_free_pages() which does the aging
of pages.  What functionality would a pagebuf daemon add in
this regard ?

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

