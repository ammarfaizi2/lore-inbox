Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423094AbWJSCz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423094AbWJSCz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 22:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWJSCz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 22:55:59 -0400
Received: from ns.suse.de ([195.135.220.2]:46471 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030293AbWJSCz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 22:55:58 -0400
From: Neil Brown <neilb@suse.de>
To: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 19 Oct 2006 12:55:52 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17718.59704.690819.622080@cse.unsw.edu.au>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] nfs endianness annotations
In-Reply-To: message from Al Viro on Thursday October 19
References: <E1GX7zV-00047C-PO@ZenIV.linux.org.uk>
	<1161206763.6095.172.camel@lade.trondhjem.org>
	<17718.51050.186385.512984@cse.unsw.edu.au>
	<20061019012600.GR29920@ftp.linux.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 19, viro@ftp.linux.org.uk wrote:
> 
> Folks, seriously, please run sparse after changes; it's a simple matter of
> make C=2 CF=-D__CHECK_ENDIAN__ fs/nfs*/; nothing tricky and it saves a lot
> of potential PITA...

I'll try to remember.. I just tried drivers/md/ and it spits quite a
few endian errors. I see about fixing those up too.

NeilBrown


