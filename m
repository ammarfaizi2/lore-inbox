Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289490AbSAVWWl>; Tue, 22 Jan 2002 17:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289491AbSAVWWc>; Tue, 22 Jan 2002 17:22:32 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:21264 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289490AbSAVWWS>;
	Tue, 22 Jan 2002 17:22:18 -0500
Date: Tue, 22 Jan 2002 20:21:57 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Chris Mason <mason@suse.com>, Andreas Dilger <adilger@turbolabs.com>,
        Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4DE22D.4090904@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201222014370.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Hans Reiser wrote:

> Yes, it should get twice as much pressure, but that does not mean it
> should free twice as many pages, it means it should age twice as many
> pages, and then the accesses will un-age them.
>
> Make more sense now?

So basically you are saying that each filesystem should
implement the code to age all pages equally and react
equally to memory pressure ...

... essentially duplicating what the current VM already
does!

regads,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

