Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264869AbRGPBVT>; Sun, 15 Jul 2001 21:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265503AbRGPBVK>; Sun, 15 Jul 2001 21:21:10 -0400
Received: from mail207.mail.bellsouth.net ([205.152.58.147]:53439 "EHLO
	imf07bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S264869AbRGPBVB>; Sun, 15 Jul 2001 21:21:01 -0400
Date: Sun, 15 Jul 2001 21:22:33 -0400 (EDT)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Alexander Viro <viro@math.psu.edu>
cc: Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>, reiser@namesys.com
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <Pine.GSO.4.21.0107152051340.24930-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.20.0107152104290.1295-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Jul 2001, Alexander Viro wrote:

> 
> 
> On Sun, 15 Jul 2001 volodya@mindspring.com wrote:
> 
> > Umm that is very interesting - I was rather sure there were some problems
> > a while ago (2.2.x ?). Is there anything special necessary to use large
> > files ? Because I tried to create a 3+gig file and now I cannot ls or rm
> > it. (More details: the file was created using dd from block device (tried
> > to backup a smaller ext2 partition), ls and rm say  "Value too large for
> > defined data type" and I upgraded everything mentioned in Documentation/Changes).
> 
> <shrug> you need fileutils built with large file support enabled (basically,
> it should use stat64(), etc. and pass O_LARGEFILE to open()) and you need
> sufficiently recent libc. But that's the same regardless of fs type.
> 

May I ask where does one get a patched fileutils package ? I have just
downloaded fileutils-4.1 from prep.ai.mit.edu and it has 0 information in 
README, configure --help, etc on how to enable this and when compiled ls
still complains.

                   thanks !

                            Vladimir Dergachev



