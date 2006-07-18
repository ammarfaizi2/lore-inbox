Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWGRPWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWGRPWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWGRPWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:22:10 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:44688 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932262AbWGRPWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:22:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AtaLacGb3mOsX9BJWcubEoMrLB5S2eYIwgmAAxrT2CmEnTT0riUu8xbHDnPVAfx5TqvNFHBkZBwAi2TEAn0jNcRcUt2jwRmURdCJUaAunZlSmyZp7iHGJ8hR6AIQRtMsFTs4V7UFLkyrZz6oNJXh0sBALbs/6ij9So7w00/x358=
Message-ID: <4745278c0607180822u55ffe5b4g333e2e6457b37d02@mail.gmail.com>
Date: Tue, 18 Jul 2006 11:22:05 -0400
From: "Vishal Patil" <vishpat@gmail.com>
To: "Gary Funck" <gary@intrepid.com>
Subject: Re: Generic B-tree implementation
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <JCEPIPKHCJGDMPOHDOIGCELEDFAA.gary@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4745278c0607180630m39040ad7neac25c1a64399aff@mail.gmail.com>
	 <JCEPIPKHCJGDMPOHDOIGCELEDFAA.gary@intrepid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

B-trees are good for parellel updates as well. Anyway it would be
great to have inputs from other folks about how B-trees could help
inside the kernel (if at all)

- Vishal

On 7/18/06, Gary Funck <gary@intrepid.com> wrote:
>
> Vishal Patil wrote:
> > I said B-Tree and not binary tree, please read the explaination about
> > B-tree at http://en.wikipedia.org/wiki/B-tree. Also I am aware of AVL
> > trees.
> >
> > I never claimed that my implementation is better or anything like
> > that. I posted the code so that someone in need of the data structure
> > might use it. Also I would be willing them to help with their project.
>
> My reason for pointing out the other data strucutres is to note that there
> might be search tree representations that are more appropriate for
> implementation inside the kernel, and to perhaps encourage you to have
> a look at implementing them as well.  Red-black trees in particular have
> the property that they're reasonably well-balanced, and that the balancing
> algorithm makes use of local information.  That means that the kernel might
> be able to limit the level of locking required to update the tree.
>
> I liked your B-tree implementation, and have saved a copy.  Too bad there
> isn't the C/C++ equivalent of CPAN (comp.unix.sources is so passe`).  Your
> B-tree implementation would make a nice addition to an archive of
> handy C algorithm implementations.
>


-- 
Motivation will almost always beat mere talent.
