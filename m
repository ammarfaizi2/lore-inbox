Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132071AbRBFA4Z>; Mon, 5 Feb 2001 19:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135357AbRBFA4Q>; Mon, 5 Feb 2001 19:56:16 -0500
Received: from zeus.kernel.org ([209.10.41.242]:56006 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132071AbRBFA4F>;
	Mon, 5 Feb 2001 19:56:05 -0500
Date: Tue, 6 Feb 2001 00:56:22 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: <paul@fogarty.jakma.org>
To: Samuel Flory <sflory@valinux.com>
cc: Josh Durham <jmd@aoe.vt.edu>, <reiserfs-list@namesys.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] NFS and reiserfs
In-Reply-To: <3A7F0492.AD31A2FC@valinux.com>
Message-ID: <Pine.LNX.4.31.0102060050500.10669-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Samuel Flory wrote:

> someone (you?) talking about v3 issues with SGI boxes under 2.4 on the
> nfs list.  I didn't much pay much attention as it wasn't an issue I
> could help with.

that might have been me...

the issues were related to how IRIX nfs client expects server to
behave wrt to device files and other special files. First problemo
was fixed, second one (FIFOs) is apparently undefined for NFS.

also have problems with linux needing a bit of tuning wrt to NFS over
lossy links. (eg a 10<->100MB bridging hub).

but these are very very specific issues. IME if you have a good
network connection and you don't need IRIX to be diskless hanging off
a Linux NFS server then NFSv3 works extremely well.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
The price one pays for pursuing any profession, or calling, is an intimate
knowledge of its ugly side.
		-- James Baldwin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
