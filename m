Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289101AbSAUJV4>; Mon, 21 Jan 2002 04:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289105AbSAUJVr>; Mon, 21 Jan 2002 04:21:47 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:32519 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S289101AbSAUJVe>; Mon, 21 Jan 2002 04:21:34 -0500
Date: Mon, 21 Jan 2002 11:21:30 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020121092130.GA51774@niksula.cs.hut.fi>
In-Reply-To: <20020120210841.GU51774@niksula.cs.hut.fi> <200201210906.g0L96vT2001762@tigger.cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201210906.g0L96vT2001762@tigger.cs.uni-dortmund.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 10:06:57AM +0100, you [Horst von Brand] claimed:
> 
> There are filesystems around (MSDOS, VFAT) that haven't got fixed inode
> numbers for files. There are networked filesystems where this would need
> radical changes to the server side. Some even make up inode numbers on the
> fly IIRC.

True.
 
> If in dire need, you could hack something together for <favorite
> filesystem> by groveling over the disk image. e2fsprogs' libraries should
> come handy...

Well, I'll have to come up with the dire need first - or any need indeed :).
Just playing around with the idea.

IIRC, Stephen Tweedie had made such a patch for ext2.


-- v --

v@iki.fi
