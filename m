Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136668AbREJOVf>; Thu, 10 May 2001 10:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136666AbREJOVZ>; Thu, 10 May 2001 10:21:25 -0400
Received: from msp-26-178-183.mn.rr.com ([24.26.178.183]:21426 "HELO
	msp-26-178-183.mn.rr.com") by vger.kernel.org with SMTP
	id <S136663AbREJOVE>; Thu, 10 May 2001 10:21:04 -0400
Date: Thu, 10 May 2001 09:21:10 -0500
From: Shawn <z3rk@ahkbarr.dynip.com>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010510092110.A15249@ahkbarr.dynip.com>
In-Reply-To: <01050910381407.26653@bugs> <20010510134453.A6816@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010510134453.A6816@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Thu, May 10, 2001 at 01:44:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10, Matthias Andree rearranged the electrons to read:
> On Wed, 09 May 2001, Mart?n Marqu?s wrote:
> 
> > There has also been lots of talks about reiserfs being the cause of
> > some data lose and performance lose (not sure about this last one).
> 
> I never experienced ReiserFS data loss, but I did experience read
> performance loss over ext2fs and switched that file system back to ext2.
> The ReiserFS people could not reproduce the problem, so I'm not sure
> what was the actual cause.
> 
> ext3fs has never given me any problems, but I did not have it in
> production use where I discovered major ReiserFS <-> kNFSd
> incompatibilities. ext3 has a 0.0.x version number which suggests it's
> not meant for production use. 
> 
> XFS is claimed to work with NFS, but not currently availabe for Linux
> 2.4.4.

$ uname -r
2.4.4-ac5.xfs
$ uptime
  9:20am  up 1 day, 18:28,  4 users,  load average: 0.00, 0.00, 0.00

--
Hob Goblin
z3rk@ahkbarr.dynip.com

A society that will trade a little liberty for a little order will lose
both and deserve neither. - Thomas Jefferson
