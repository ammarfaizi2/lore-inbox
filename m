Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSHOR3e>; Thu, 15 Aug 2002 13:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSHOR3e>; Thu, 15 Aug 2002 13:29:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42757 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317258AbSHOR3d>; Thu, 15 Aug 2002 13:29:33 -0400
Date: Thu, 15 Aug 2002 10:35:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dax Kelson <dax@gurulabs.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Kendrick M. Smith" <kmsmith@umich.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "nfs@lists.sourceforge.net" <nfs@lists.sourceforge.net>,
       <beepy@netapp.com>, <trond.myklebust@fys.uio.no>
Subject: Re: Will NFSv4 be accepted?
In-Reply-To: <Pine.LNX.4.44.0208141938350.31203-100000@mooru.gurulabs.com>
Message-ID: <Pine.LNX.4.44.0208151027510.3130-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Aug 2002, Dax Kelson wrote:
> 
> Q for Linus: What's the prospect of adding crypto to the kernel?

For a good enough excuse, and with a good enough argument that it's not 
likely to be a big export problem, I don't think it's impossible any more.

However, the "good enough excuse" has to be better than "some technically 
excellent, but not very widespread" thing. 

Quite frankly, I personally suspect that crypto is one of those things 
that will be added by vendor kernels first - if vendors are willing to 
handle whatever export issues there are, that's good, and if they aren't, 
then the standard kernel cannot really force it upon them anyway.

I personally doubt that NFS would be the thing driving this. Judging by 
past performance, NFS security issues don't seem to bother people. I'd 
personally assume that the thing that would be important enough to people 
for vendors to add it is VPN or encrypted (local) disks.

		Linus

