Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWGTAbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWGTAbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 20:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWGTAbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 20:31:08 -0400
Received: from ns1.suse.de ([195.135.220.2]:36274 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964885AbWGTAbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 20:31:07 -0400
From: Neil Brown <neilb@suse.de>
To: Martin Filip <bugtraq@smoula.net>
Date: Thu, 20 Jul 2006 10:30:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17598.52873.335796.13969@cse.unsw.edu.au>
Cc: David Greaves <david@dgreaves.com>, linux-kernel@vger.kernel.org
Subject: Re: NFS and partitioned md
In-Reply-To: message from Martin Filip on Tuesday July 18
References: <1151355145.4460.16.camel@archon.smoula-in.net>
	<17568.31894.207153.563590@cse.unsw.edu.au>
	<1151432312.11996.32.camel@reaver.netbox-in.cz>
	<17571.19699.980491.970386@cse.unsw.edu.au>
	<44BD2A29.8060405@dgreaves.com>
	<1153253099.26360.3.camel@archon.smoula-in.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 18, bugtraq@smoula.net wrote:
> Hi,
> 
> my solution was to use fsid parameter for exports... maybe some other
> mechanism for selecting fsids could be created instead of fsid = device
> minor

Yes.  Better management of fsid is on my wishlist for nfs-utils.
Unfortunately I haven't had any really clever ideas yet.

NeilBrown
