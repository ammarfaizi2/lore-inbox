Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285593AbSAPXDN>; Wed, 16 Jan 2002 18:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286137AbSAPXDE>; Wed, 16 Jan 2002 18:03:04 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:32262 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S285593AbSAPXCq>; Wed, 16 Jan 2002 18:02:46 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 16 Jan 2002 15:08:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Brian Strand <bstrand@switchmanagement.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: this is more interesting ...
In-Reply-To: <3C45ECC2.6090208@switchmanagement.com>
Message-ID: <Pine.LNX.4.40.0201161508090.934-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Brian Strand wrote:

> Davide Libenzi wrote:
>
> >Booting my machine with vanilla 2.5.3-pre1 ( obsiously with corrected
> >headers inclusion fix ) i've got and error from UMSDOS layer reporting a
> >failing msdos_read_super() ( at boot ) and a panic about a failure to
> >mount root. The interesting thing is that i do not have any msdos mounts,
> >least of all root.
> >
> This might be the problem with msdos_read_super mistaking a reiserfs
> superblock for a FAT superblock, as discussed in a lkml thread starting
> Jan 13 14:38 -0800 with subject "Boot failure: msdos pushes in front of
> reiserfs" from Matthias Andree <matthias.andree@stud.uni-dortmund.de>.

I'll look into, thanks.
Linus, if something that solves this shows up let me know ...



- Davide


