Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284964AbRLFEGW>; Wed, 5 Dec 2001 23:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284968AbRLFEGC>; Wed, 5 Dec 2001 23:06:02 -0500
Received: from dsl-213-023-038-088.arcor-ip.net ([213.23.38.88]:15377 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284964AbRLFEFx>;
	Wed, 5 Dec 2001 23:05:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: Ext2 directory index: ALS paper and benchmarks
Date: Thu, 6 Dec 2001 05:08:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16BpcG-0000mI-00@starship.berlin> <3C0EEC6B.7060009@namesys.com>
In-Reply-To: <3C0EEC6B.7060009@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Bppx-0000mN-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 6, 2001 04:56 am, Hans Reiser wrote:
> >On December 6, 2001 04:41 am, you wrote:
> >
> >>ReiserFS is an Htree by your definition in your paper, yes?
> >
> >You've got a hash-keyed b*tree over there.  The htree is fixed depth.
> >
> 
> B*trees are fixed depth.  B-tree usually means height-balanced.  

I was relying on definitions like this:

  B*-tree

  (data structure)

  Definition: A B-tree in which nodes are kept 2/3 full by redistributing
  keys to fill two child nodes, then splitting them into three nodes.

To tell the truth, I haven't read your code that closely, sorry, but I got 
the impression that you're doing rotations for balancing no?  If not then 
have you really got a b*tree?

--
Daniel
