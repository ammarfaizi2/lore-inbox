Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284960AbRLFDwL>; Wed, 5 Dec 2001 22:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284961AbRLFDwB>; Wed, 5 Dec 2001 22:52:01 -0500
Received: from dsl-213-023-038-088.arcor-ip.net ([213.23.38.88]:7697 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284960AbRLFDvo>;
	Wed, 5 Dec 2001 22:51:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: Ext2 directory index: ALS paper and benchmarks
Date: Thu, 6 Dec 2001 04:54:31 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com>
In-Reply-To: <3C0EE8DD.3080108@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16BpcG-0000mI-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On December 6, 2001 04:41 am, you wrote:
> I can't comment on your benchmarks because I was on the way to bed when 
> I read this.  I am sure though that you and Stephen are doing your usual 
> good programming.
> 
> ReiserFS is an Htree by your definition in your paper, yes?

You've got a hash-keyed b*tree over there.  The htree is fixed depth.

> Daniel Phillips wrote:
> >So it seems that for realistic cases, ext2+htree outperforms reiserfs 
> >quite dramatically.  (Are you reading, Hans?  Fighting words... ;-)
> 
> Have you ever seen an application that creates millions of files create 
> them in random order?

We haven't seen an application create millions of files yet.  However, the 
effects I'm describing are readily apparent at much smaller numbers.

> Almost always there is some non-randomness in the 
> order, and our newer hash functions are pretty good at preserving it. 
>  Applications that create millions of files are usually willing to play 
> nice for an order of magnitude performance gain also.....

To be fair, I should rerun the tests with your linear-congruential hash, I'll 
try to get time for that.

--
Daniel
