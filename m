Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275082AbRKHQUw>; Thu, 8 Nov 2001 11:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275178AbRKHQUm>; Thu, 8 Nov 2001 11:20:42 -0500
Received: from quasar.osc.edu ([192.148.249.15]:16257 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S275082AbRKHQU3>;
	Thu, 8 Nov 2001 11:20:29 -0500
Date: Thu, 8 Nov 2001 11:20:10 -0500
From: Pete Wyckoff <pw@osc.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Bob Smart <smart@hpc.CSIRO.AU>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: handling NFSERR_JUKEBOX
Message-ID: <20011108112010.C5145@osc.edu>
In-Reply-To: <200111061036.VAA07886@trout.hpc.CSIRO.AU> <shsg07sknsf.fsf@charged.uio.no> <shs4ro7a2n2.fsf_-_@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shs4ro7a2n2.fsf_-_@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Nov 07, 2001 at 12:41:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trond.myklebust@fys.uio.no said:
> > I'm still not convinced this is a good idea, but if you are
> > going to do things inside the NFS client, why don't you instead
> > write a wrapper function around rpc_call_sync() for
> > fs/nfs/nfs3proc.c. Something like
> 
> ...and here's the full patch that implements it...

Works like a charm.  Glad you allowed yourself to be badgered
into writing the proper code to handle EJUKEBOX.  I'll destroy
my icky version.

Can you push it forward to Linus for general inclusion?

		-- Pete
