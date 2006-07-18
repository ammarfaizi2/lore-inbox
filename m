Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWGRNan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWGRNan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWGRNan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:30:43 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:63426 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932196AbWGRNam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:30:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X5ycNJrCF+vq3w0oSz3zIDBCHzCiLmnDHz9LhVBY+5rEAB96u95IBxXXxOz6Kdm6nEeH2yI1qY6IAYofBtKsBySvHH7Yw2cUaeHz0muiWBYDycFUhttkeMz+opwEiQemq1ZIu3vSoXj+SORWMKjRPCDNFmI/0Z8NEIgiiowHtnE=
Message-ID: <4745278c0607180630m39040ad7neac25c1a64399aff@mail.gmail.com>
Date: Tue, 18 Jul 2006 09:30:40 -0400
From: "Vishal Patil" <vishpat@gmail.com>
To: "Gary Funck" <gary@intrepid.com>
Subject: Re: Generic B-tree implementation
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <JCEPIPKHCJGDMPOHDOIGIELCDFAA.gary@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4745278c0607171902pc218a9dn9c63dd6670ac7249@mail.gmail.com>
	 <JCEPIPKHCJGDMPOHDOIGIELCDFAA.gary@intrepid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gary

I said B-Tree and not binary tree, please read the explaination about
B-tree at http://en.wikipedia.org/wiki/B-tree. Also I am aware of AVL
trees.

I never claimed that my implementation is better or anything like
that. I posted the code so that someone in need of the data structure
might use it. Also I would be willing them to help with their project.

- Vishal

On 7/18/06, Gary Funck <gary@intrepid.com> wrote:
>
> Vishal Patil wrote:
> >
> > I am attaching source files containing a very generic implementation
> > of B-trees in C. The implementation corresponds to in memory B-Tree
> > data structure. The B-tree library consists of two files, btree.h and
> > btree.c. I am also attaching a sample program main.c which should
> > hopefully make the use of the library clear.
>
> Couple of thoughts:
>
> 1. red/black b-trees have superior worst case performance as it
> relates to rebalancing, and the implementation doesn't add a
> lot of complexity:
> http://www.nist.gov/dads/HTML/redblack.html
>
> 2. Paul Vixie's b-tree implementation has been around since the mid-80's
> or so, and simply from an historical perspective is worth a look
> (comp.sources.unix anyone?):
> http://www.isc.org/index.pl?/sources/devel/func/avl-subs-2.php
>
> 3. GCC uses 'splay trees' to good advantage:
> http://www.nist.gov/dads/HTML/splaytree.html
> which have the property that most-recently referenced nodes
> tend to be higher up in the tree.
>
>


-- 
Motivation will almost always beat mere talent.
