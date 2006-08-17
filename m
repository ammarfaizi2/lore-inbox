Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWHQGt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWHQGt1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 02:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWHQGt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 02:49:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40071 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750959AbWHQGt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 02:49:26 -0400
From: Neil Brown <neilb@suse.de>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Date: Thu, 17 Aug 2006 16:49:18 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17636.4462.975774.528003@cse.unsw.edu.au>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [NFS] 2.6.17.8 - do_vfs_lock: VFS is out of sync with lock manager!
In-Reply-To: message from Jesper Juhl on Tuesday August 8
References: <9a8748490608080739w2e14e5ceg44a7bf0a3b475704@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 8, jesper.juhl@gmail.com wrote:
> I have some webservers that have recently started reporting the
> following message in their logs :
> 
>   do_vfs_lock: VFS is out of sync with lock manager!


I can imagine that happening if you mount with '-o nolocks'.
Then a non-blocking lock could cause that message (I think).
Can you conform that you aren't using 'nolocks'.

Thanks,
NeilBrown
