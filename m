Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSHOEFb>; Thu, 15 Aug 2002 00:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSHOEFb>; Thu, 15 Aug 2002 00:05:31 -0400
Received: from dsl-65-186-160-165.telocity.com ([65.186.160.165]:19730 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id <S316541AbSHOEFb>; Thu, 15 Aug 2002 00:05:31 -0400
Date: Thu, 15 Aug 2002 00:07:13 -0400
To: Dax Kelson <dax@gurulabs.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Kendrick M. Smith" <kmsmith@umich.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "nfs@lists.sourceforge.net" <nfs@lists.sourceforge.net>,
       beepy@netapp.com, trond.myklebust@fys.uio.no, torvalds@transmeta.com
Subject: Re: Will NFSv4 be accepted?
Message-ID: <20020815040713.GA18419@fieldses.org>
References: <1029375327.28240.35.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208141938350.31203-100000@mooru.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208141938350.31203-100000@mooru.gurulabs.com>
User-Agent: Mutt/1.3.28i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 07:51:56PM -0600, Dax Kelson wrote:
> Right, I do understand that Kerberized/GSS NFS is not exclusive to NFSv4.  
> However, right now, there is only one way to get Kerberized NFS. The CITI
> NFSv4 patches.
> 
> Those patches are, in their estimation, ready for inclusion.  NFSv3 
> support is "coming down the pipeline". 

The minimal NFSv4 patches which Kendrick has submitted are ready for
inclusion, but those do not include rpcsec_gss support.  The only
patches which include rpcsec_gss support are patches against 2.4.18, and
they aren't in good enough shape yet, though we hope they will be soon!

--Bruce F.
