Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965300AbVLRW1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965300AbVLRW1A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbVLRW07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:26:59 -0500
Received: from ns2.suse.de ([195.135.220.15]:11186 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965300AbVLRW06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:26:58 -0500
From: Neil Brown <neilb@suse.de>
To: "Szloboda Zsolt" <slobo@t-online.hu>
Date: Mon, 19 Dec 2005 09:26:47 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17317.57895.187139.651739@cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: raid over sata - write barrier
In-Reply-To: message from Szloboda Zsolt on Sunday December 18
References: <17317.51966.827057.524008@cse.unsw.edu.au>
	<JDEMIGCBPIDENEAIIGKPMECCCLAA.slobo@t-online.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday December 18, slobo@t-online.hu wrote:
> with kernel 2.6.15, raid1
> do I have to use the
> -o barrier=1
> mount option (or something else) when I mount the md device?

You don't have to do anything special to the raid1.

If the filesystem requires "-o barrier=1" (which I believe it does),
then you need to use that no-matter what device the filesystem is
mounted from.

NeilBrown
