Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289319AbSAVOjt>; Tue, 22 Jan 2002 09:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289320AbSAVOjf>; Tue, 22 Jan 2002 09:39:35 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:1555 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289319AbSAVOjV>;
	Tue, 22 Jan 2002 09:39:21 -0500
Date: Tue, 22 Jan 2002 12:39:00 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Chris Mason <mason@suse.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, Hans Reiser <reiser@namesys.com>,
        Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <1965690000.1011708208@tiny>
Message-ID: <Pine.LNX.4.33L.0201221234470.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Chris Mason wrote:

> It seems like the basic features we are suggesting are very close, I'll try
> one last time to make a case against the 'free_some_pages' call ;-)

> The FS doesn't know how long a page has been dirty, or how often it
> gets used,

In an efficient system, the FS will never get to know this, either.

The whole idea behind the VFS and the VM is that calls to the FS
are avoided as much as possible, in order to keep the system fast.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

