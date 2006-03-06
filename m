Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWCFFhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWCFFhK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 00:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWCFFhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 00:37:10 -0500
Received: from ns.suse.de ([195.135.220.2]:45705 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751259AbWCFFhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 00:37:09 -0500
From: Neil Brown <neilb@suse.de>
To: Iain William Wiseman <bibble@paradise.net.nz>
Date: Mon, 6 Mar 2006 16:36:08 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17419.51784.875639.977675@cse.unsw.edu.au>
Cc: Iain William Wiseman <iwiseman@eservglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops [NFS server crash]
In-Reply-To: message from Iain William Wiseman on Monday March 6
References: <440B4FE3.4000809@eservglobal.com>
	<17419.47968.756969.377865@cse.unsw.edu.au>
	<440BC09A.2080404@paradise.net.nz>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 6, bibble@paradise.net.nz wrote:
> Hi,
> 
> Firstly stupid me never saw the Bugzilla link first time through. This 
> is now logged under Bug 6172

You should be aware that bugzilla is not universally popular.  I
hardly ever look at it myself and perfer to deal with issues simply in
the mailing list.

> 
> This is a vanilla 2.6.15.4 kernel no patches.

Thanks for that confirmation.  It is always best to be sure.

> 
> Several attempt were made to start NFS with /etc/init.d/nfs start. I 
> understood this would start portmap. Am I wrong? Possibly my iptables 
> provented it.  I have been experimenting with arno firewall.

The functions in /etc/init.d are very dependant on distribution.  I
gather you are using RedHat, and I know nothing about redhat's init.d.

However I suspect a badly configured firewall could be an issue and
disabling the firewall before trying again would be a good idea.

> 
> Thanks for responding and sorry for logging twice.

Don't worry about that.  Twice is much better than never.  It is very
easy to ignore a second copy of a bug report (when you read
linux-kernel you have to get good at ignoring things:-)

> 
> Iain
> New Zealand

NeilBrown
