Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUA3BqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUA3BoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:44:20 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:20460 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S266532AbUA3BhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:37:01 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Fri, 30 Jan 2004 12:36:16 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16409.46352.877421.233677@notabene.cse.unsw.edu.au>
Cc: hanasaki <hanasaki@hanaden.com>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] NFS rpc and stale handles on 2.6.x servers
In-Reply-To: message from Mike Fedyk on Thursday January 29
References: <4014675D.2040405@hanaden.com>
	<16409.43367.545322.356713@notabene.cse.unsw.edu.au>
	<20040130012534.GE2445@srv-lnx2600.matchmail.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday January 29, mfedyk@matchmail.com wrote:
> On Fri, Jan 30, 2004 at 11:46:31AM +1100, Neil Brown wrote:
> > On Sunday January 25, hanasaki@hanaden.com wrote:
> > > The below is being reported, on and off, when hitting nfs-kernel-servers
> > > running on 2.6.0 and 2.6.1  Could someone tell me if this is smoe bug or
> > > what?  Thanks
> > > 	RPC request reserved 0 but used 124
> > > 
> > > Debian sarge
> > > nfs-kernel-server
> > > am-untils
> > > nfsv3 over tcp
> > > 
> > 
> > stale file handles is a known bug that is fixed in the but BK and will
> > be in 2.6.3.
> 
> do you mean 2.6.2?

Yeh, 2.6.2 as well.. But definitely 2.6.3 :-)

> 
> I've merged the nfsd stale file handles into 2.6.1-bk2 and it is working
> fine on a nfs server here...

good, thanks.
NeilBrown
