Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUA3B1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUA3B1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:27:12 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:16013 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S266310AbUA3B1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:27:10 -0500
Date: Thu, 29 Jan 2004 17:25:34 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: hanasaki <hanasaki@hanaden.com>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] NFS rpc and stale handles on 2.6.x servers
Message-ID: <20040130012534.GE2445@srv-lnx2600.matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	hanasaki <hanasaki@hanaden.com>, nfs@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <4014675D.2040405@hanaden.com> <16409.43367.545322.356713@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16409.43367.545322.356713@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 11:46:31AM +1100, Neil Brown wrote:
> On Sunday January 25, hanasaki@hanaden.com wrote:
> > The below is being reported, on and off, when hitting nfs-kernel-servers
> > running on 2.6.0 and 2.6.1  Could someone tell me if this is smoe bug or
> > what?  Thanks
> > 	RPC request reserved 0 but used 124
> > 
> > Debian sarge
> > nfs-kernel-server
> > am-untils
> > nfsv3 over tcp
> > 
> 
> stale file handles is a known bug that is fixed in the but BK and will
> be in 2.6.3.

do you mean 2.6.2?

I've merged the nfsd stale file handles into 2.6.1-bk2 and it is working
fine on a nfs server here...
