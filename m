Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbRGPAsx>; Sun, 15 Jul 2001 20:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267163AbRGPAso>; Sun, 15 Jul 2001 20:48:44 -0400
Received: from mail315.mail.bellsouth.net ([205.152.58.175]:39724 "EHLO
	imf15bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S267160AbRGPAsc>; Sun, 15 Jul 2001 20:48:32 -0400
Date: Sun, 15 Jul 2001 20:50:03 -0400 (EDT)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Alexander Viro <viro@math.psu.edu>
cc: Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>, reiser@namesys.com
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <Pine.GSO.4.21.0107151204060.24930-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.20.0107152032440.1154-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Jul 2001, Alexander Viro wrote:

> 
> 
> On Sun, 15 Jul 2001 volodya@mindspring.com wrote:
> 
> > Which is a good point - can ext2 handle more than 4gig partitions ? I have
> 
> It can.
> 
> > some vague ideas that it doesn't (and that it does not handle files more
> > than 2gig long).
> 
> It does.
> 


Umm that is very interesting - I was rather sure there were some problems
a while ago (2.2.x ?). Is there anything special necessary to use large
files ? Because I tried to create a 3+gig file and now I cannot ls or rm
it. (More details: the file was created using dd from block device (tried
to backup a smaller ext2 partition), ls and rm say  "Value too large for
defined data type" and I upgraded everything mentioned in Documentation/Changes).

                         Vladimir Dergachev

PS Yep, the new limits are clearly documented in
Documentation/filesystems/ext2.txt - sorry for bothering anyone..


