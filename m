Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269369AbUIYRWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269369AbUIYRWc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 13:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269370AbUIYRWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 13:22:32 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:32983 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S269369AbUIYRWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 13:22:30 -0400
Date: Sat, 25 Sep 2004 19:22:23 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: 2.6.9-rc2-mm3 breaks amanda (was: 2.6.9-rc2-mm3)
Message-ID: <20040925172223.GA14562@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20040924014643.484470b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924014643.484470b1.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm3/
> 
> - This is a quick not-very-well-tested release - it can't be worse than
>   2.6.9-rc2-mm2, which had a few networking problems.

Some problems appear to persist (and have also haunted earlier -mm
versions of 2.6.9-rc2, haven't checked older -mm recently)

When running an Amanda (network backup) server with a 2.6.9-rc2-mm3
kernel, the backup size estimates pass properly but no backup data is
recevied from remote Amanda clients, only local backups are made.

I understand too little of the exact Amanda protocol to tell more,
vanilla 2.6.7 was fine though.

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
