Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288990AbSAUAyB>; Sun, 20 Jan 2002 19:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288991AbSAUAxv>; Sun, 20 Jan 2002 19:53:51 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:50441 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288990AbSAUAxf>;
	Sun, 20 Jan 2002 19:53:35 -0500
Date: Sun, 20 Jan 2002 22:52:51 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4B645B.8090703@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201202252070.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Hans Reiser wrote:

> Not if you provide a proper design of a master cache manager.
> Really, all you have to do is have the subcache managers designed to
> free the same number of pages on average in response to pressure, and
> to pressure them in proportion to their size, and it is pretty simple
> for VM.

I take it you're volunteering to bring ext3, XFS, JFS,
JFFS2, NFS, the inode & dentry cache and smbfs into
shape so reiserfs won't get unbalanced ?

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

