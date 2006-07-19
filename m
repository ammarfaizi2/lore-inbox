Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWGSNep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWGSNep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 09:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWGSNep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 09:34:45 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:20977 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964815AbWGSNeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 09:34:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lHr6LUZPM0RJQVVWjGrHherYnGZ1OM6ypbCr/zguL/5YiAQWZF3AInGApdiScMI7UpkEXpsUg4kHUoN9ITPLs6p9PUNlHs/QMbLHmodSUkKvucL5fRAtGNI543vVsI1AQhD/f1Es4psnudMMAG+sbMAFl4w/usRdykfMHHhvl9Q=
Message-ID: <4745278c0607190634l3ab43bb7t3d2a7b80c22d44c4@mail.gmail.com>
Date: Wed, 19 Jul 2006 09:34:43 -0400
From: "Vishal Patil" <vishpat@gmail.com>
To: "Anton Altaparmakov" <aia21@cam.ac.uk>
Subject: Re: Generic B-tree implementation
Cc: "Gary Funck" <gary@intrepid.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1153294394.13071.3.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4745278c0607180630m39040ad7neac25c1a64399aff@mail.gmail.com>
	 <JCEPIPKHCJGDMPOHDOIGCELEDFAA.gary@intrepid.com>
	 <4745278c0607180822u55ffe5b4g333e2e6457b37d02@mail.gmail.com>
	 <1153294394.13071.3.camel@imp.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can get rid of recursions using loops, will need to work a little more on it.

Also I will be working on developing a patch for VM management using
B-trees instead of RB-trees.

- Vishal

On 7/19/06, Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> On Tue, 2006-07-18 at 11:22 -0400, Vishal Patil wrote:
> > B-trees are good for parellel updates as well. Anyway it would be
> > great to have inputs from other folks about how B-trees could help
> > inside the kernel (if at all)
>
> B-trees are mostly used in file systems in the kernel.  For example NTFS
> and HFS (and I think HPFS) use B-trees for various metadata like
> directory indexes for example.
>
> But of course your implementation is purely userspace and cannot be used
> in the kernel (you use recursion for example...) so I am not sure how
> you envisage to help the kernel with your code...
>
> Best regards,
>
>         Anton
> --
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
> Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
> WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
>
>


-- 
Motivation will almost always beat mere talent.
