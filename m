Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269541AbUHZTxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269541AbUHZTxW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269527AbUHZTuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:50:35 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:178 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269515AbUHZTqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:46:03 -0400
Subject: Re: silent semantic changes with reiser4
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       torvalds@osdl.org, reiserfs-list@namesys.com
In-Reply-To: <20040826193436.GA8693@lst.de>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com>
	 <20040826014542.4bfe7cc3.akpm@osdl.org> <412DAC59.4010508@namesys.com>
	 <1093548414.5678.74.camel@krustophenia.net>  <20040826193436.GA8693@lst.de>
Content-Type: text/plain
Message-Id: <1093549535.5678.79.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 15:45:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 15:34, Christoph Hellwig wrote:
> On Thu, Aug 26, 2004 at 03:26:55PM -0400, Lee Revell wrote:
> > OK, real world example.  My roommate has an AKAI MPC-2000, a very
> > popular hardware sampler from the 90's.  The disk format is known,there
> > are a few utilities to edit the disks on a PC and extract the PCM
> > samples, but there are no tools to mount it on a modern PC.  Are you
> > saying that, since I know the MPC disk format, I could write a reiser4
> > plugin to mount an MPC drive?
> > 
> > If so, then Hans has an excellent point.  Users do want this kind of
> > thing, and it is worth having to fix tar et al.
> 
> You don't need reiser4 for that, writing read-only linux filesystems is
> trivial as soon as you have a specification of the ondisk format.
> 

Of course I could just write an MPC filesystem driver.  And, like Andrew
said, a filesystem normally gets new features with 'patch -p1'.  My
question, which was answered by a previous post, was whether the same
could be done in a reiser4 plugins.

Lee

