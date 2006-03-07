Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWCGXWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWCGXWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWCGXV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:21:59 -0500
Received: from cantor2.suse.de ([195.135.220.15]:38310 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964802AbWCGXV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:21:58 -0500
From: Neil Brown <neilb@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Date: Wed, 8 Mar 2006 10:20:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17422.5456.875119.579068@cse.unsw.edu.au>
Cc: Kirill Korotaev <dev@openvz.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Olaf Hering <olh@suse.de>,
       Jan Blunck <jblunck@suse.de>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
In-Reply-To: message from Kirill Korotaev on Tuesday March 7
References: <17414.38749.886125.282255@cse.unsw.edu.au>
	<17419.53761.295044.78549@cse.unsw.edu.au>
	<440C236A.90700@openvz.org>
	<17420.59753.598191.388029@cse.unsw.edu.au>
	<440D2633.4070301@sw.ru>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 7, dev@sw.ru wrote:
> >>In general your patch is still does what mine do, so I will be happy if 
> >>any of this is commited mainstream. In future, please, keep the 
> >>reference to original authors, this will also make sure that I'm on CC 
> >>if something goes wrong.
> > 
> > 
> > Sorry: which 'original author' did I miss ?
> I mean, it is better to mention original author 
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=114123870406751&w=2) in 
> patch description, as it makes sure that he will be on CC if this patch 
> will be discussed later again. My patch fixing this race was in -mm tree 
> for half a year already.

Which patch is that?  The race still seems to be present in -mm.

NeilBrown
