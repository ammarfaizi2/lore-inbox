Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264232AbRFYWLJ>; Mon, 25 Jun 2001 18:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264252AbRFYWKu>; Mon, 25 Jun 2001 18:10:50 -0400
Received: from Expansa.sns.it ([192.167.206.189]:22538 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S264232AbRFYWKh>;
	Mon, 25 Jun 2001 18:10:37 -0400
Date: Tue, 26 Jun 2001 00:10:30 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Shawn Starr <spstarr@sh0n.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: EXT2 Filesystem permissions (bug)?
In-Reply-To: <Pine.LNX.4.30.0106251729450.18996-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.33.0106260007220.7455-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Those are normal unix permissions, and you can use them on every kind of
Unix FS, (at less i saw them on jfs, hfs, vxfs, xfs, reiserfs, ext2, ufs).


S is suid and sgid without execution bit.
T is stiky bit without any execution bit.

(I hope my english is correct)

Luigi

On Mon, 25 Jun 2001, Shawn Starr wrote:

>
> Is this a bug or something thats undocumented somewhere?
>
> d--------T
> and
> drwSrwSrwT
>
> are these special bits? I'm not aware of +S and +T
>
> Shawn.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

