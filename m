Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288671AbSANCWZ>; Sun, 13 Jan 2002 21:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288675AbSANCWT>; Sun, 13 Jan 2002 21:22:19 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:44297 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288671AbSANCVy>;
	Sun, 13 Jan 2002 21:21:54 -0500
Date: Mon, 14 Jan 2002 00:21:44 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 1-2-3 GB
In-Reply-To: <a1sqd3$nc6$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0201140020260.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jan 2002, H. Peter Anvin wrote:

> By the way, expect user programs to fail due to lack of address space
> if you only give them 1 GB of userspace.  At 1 GB of userspace there
> is *no* address space which is compatible with the normal address
> space map available to the user process.
>
> I would personally vote against including that particular option.

It could be useful for machines where most activity happens
inside the kernel, though. Think of TUX web or ftp servers
or dedicated NFS servers.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

