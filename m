Return-Path: <linux-kernel-owner+w=401wt.eu-S932274AbXAIRR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbXAIRR0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbXAIRRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:17:25 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54060 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbXAIRRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:17:24 -0500
Date: Tue, 9 Jan 2007 12:16:24 -0500
Message-Id: <200701091716.l09HGO4l008783@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Shaya Potter <spotter@cs.columbia.edu>, Jan Kara <jack@suse.cz>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation 
In-reply-to: Your message of "Tue, 09 Jan 2007 12:03:51 EST."
             <1168362231.6054.38.camel@lade.trondhjem.org> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1168362231.6054.38.camel@lade.trondhjem.org>, Trond Myklebust writes:

> I'm saying that at the very least it should not Oops in these
> situations. As to whether or not they are something you want to handle
> more gracefully, that is up to you, but Oopses are definitely a
> showstopper.
> 
> Trond

I totally agree: oopsing is unacceptable.  Instead Unionfs should handle it
more gracefully than an oops.

Now, a lot of this "scare" in the past couple of days had been the result of
our documentation, which was intended to prevent people from mucking with
the lower f/s.  As Jeff said already yesterday, many of the possible oopses
were already fixed, and you'll be hard pressed right now to be able to
tickle more oopses.  But, to be sure, we'll run more tests, and fix whatever
else we can.

Erez.
