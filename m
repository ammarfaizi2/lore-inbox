Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291470AbSBHIZq>; Fri, 8 Feb 2002 03:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291471AbSBHIZg>; Fri, 8 Feb 2002 03:25:36 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:58891 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S291470AbSBHIZV>; Fri, 8 Feb 2002 03:25:21 -0500
Date: Fri, 8 Feb 2002 10:25:14 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020208082514.GH535637@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020207075607.GE534915@niksula.cs.hut.fi> <200202072111.g17LBig0001686@tigger.cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202072111.g17LBig0001686@tigger.cs.uni-dortmund.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 10:11:44PM +0100, you [Horst von Brand] wrote:
> Ville Herva <vherva@niksula.hut.fi> said:
> 
> [...]
> 
> > With a directory, you lose the information of in which order the patches
> > have been applied - unless of course you resort to file dates or some
> > such.
> 
> Pfui! Think patches 1, 2, 3 in this order; with 2a later superseeding 2...

Well, what way 2a supersedes 2? diff-2-2a? That would add a "2-2a" entry to
the patches dir.

But clearly this scheme is not suited for nor aimed at maintaining a tree.
It is more useful when you build a kernel from already existing bits: I
usually take stable tree X, then pre-patch Y, ac- or aa- patch Z and stuff
like newer raid/lvm patch, ide-patch, reiserfs patch, e2compr patch,
lowlatency patch etc. Later I have trouble remembering which patches went in
to that particular kernel (and which versions of those patches.)
 
> They do it in RPM's spec files, listing the patches (and saying if, and
> perhaps when, in what order) they have to be applied. A source RPM is not
> that much more than a cpio(1)-ball of the sources, patches, and .spec, very
> handy a  _single_ file.

Yes, perhaps I should make rpm out of each kernel I build - but then again
that won't help with boot disks nor with non-redhat systems.


-- v --

v@iki.fi
