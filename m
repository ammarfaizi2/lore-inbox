Return-Path: <linux-kernel-owner+w=401wt.eu-S1751317AbXAIKp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbXAIKp7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbXAIKp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:45:59 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:42299 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbXAIKp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:45:57 -0500
Date: Tue, 9 Jan 2007 05:43:33 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Christoph Hellwig <hch@infradead.org>, Erez Zadok <ezk@cs.sunysb.edu>,
       Andrew Morton <akpm@osdl.org>, Shaya Potter <spotter@cs.columbia.edu>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070109104333.GC25438@filer.fsl.cs.sunysb.edu>
References: <20070108140224.3a814b7d.akpm@osdl.org> <200701090003.l0903Z2O017720@agora.fsl.cs.sunysb.edu> <20070109095345.GB12406@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109095345.GB12406@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 09:53:45AM +0000, Christoph Hellwig wrote:
> On Mon, Jan 08, 2007 at 07:03:35PM -0500, Erez Zadok wrote:
> > However, I must caution that a file system like ecryptfs is very different
> > from Unionfs, the latter being a fan-out file system---and both have very
> > different goals.  The common code between the two file systems, at this
> > stage, is not much (and we've already extracted some of it into the "stackfs
> > layer").
> 
> I think that's an very important point.  We have a chance to get that
> non-fanout filesystems right quite easily - something I wished that would
> have been done before the ecryptfs merge - while getting fan-out stackable
> filesystems is a really hard task.

Hard or harder?

> In addition to that I know exactly
> one fan-out stackable filesystem that is posisbly useful, which is unionfs.

RAIF is another fan-out stackable fs with much more complex logic. (Just the
other day, I saw an announcement for a new version on fsdevel.)

Josef "Jeff" Sipek.

-- 
Evolution, n.:
  A hypothetical process whereby infinitely improbable events occur with
  alarming frequency, order arises from chaos, and no one is given credit.
