Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbUA3ArP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 19:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266506AbUA3ArP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 19:47:15 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:63455 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S266502AbUA3ArM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 19:47:12 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: hanasaki <hanasaki@hanaden.com>
Date: Fri, 30 Jan 2004 11:46:31 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16409.43367.545322.356713@notabene.cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] NFS rpc and stale handles on 2.6.x servers
In-Reply-To: message from hanasaki on Sunday January 25
References: <4014675D.2040405@hanaden.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday January 25, hanasaki@hanaden.com wrote:
> The below is being reported, on and off, when hitting nfs-kernel-servers
> running on 2.6.0 and 2.6.1  Could someone tell me if this is smoe bug or
> what?  Thanks
> 	RPC request reserved 0 but used 124
> 
> Debian sarge
> nfs-kernel-server
> am-untils
> nfsv3 over tcp
> 

stale file handles is a known bug that is fixed in the but BK and will
be in 2.6.3.

The "RPC request reserved 0 ..." is very odd. It does immediately
indicate a major problem, but it should be fixed, if only I could
figure out what was causing it.

I might put come more info into the message so future bug reports will
tell me more.

Thanks,
NeilBrown
