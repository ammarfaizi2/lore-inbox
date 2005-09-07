Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVIGSbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVIGSbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVIGSbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:31:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34985 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932200AbVIGSbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:31:31 -0400
Date: Wed, 7 Sep 2005 19:31:31 +0100
From: viro@ZenIV.linux.org.uk
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.6.13-git7-bird1
Message-ID: <20050907183131.GF5155@ZenIV.linux.org.uk>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905212026.GL5155@ZenIV.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset moved to -git7.  News:
	* sparse arguments fixed on ppc64 (dealt with regression)
	* -Wundef gcc warnigns all dealt with on tracked targets
Note that sparse -Wundef is broken; logs this time are with sparse
wrapper that rips -Wundef from its arguments.

Patch is on ftp.linux.org.uk/pub/peole/viro/patch-2.6.13-git7-brid1.bz2,
its splitup is in usual place and logs are in logs/*/*log19.

Added:
S26-ppc64-sparse	CHECKFLAGS on ppc64 got broken
C40-elf_class		bogus symbol used in elf_aux.c
C41-xfs			XFS __...._ENDIAN -Wundef warnings
O5-m68k-hardirq		(m68k) hardirq checks were in wrong place
O6-simserial		bogus #if (simserial)
O7-uml-mem		bogus #if (arch/um/kernel/mem.c)
O8-hisax		-Wundef fixes (hisax)
O9-smc-undef		bogus #if (smc91x)
O10-ncr5380		-Wundef fixes (ncr5380)
O11-hamachi		-Wundef fixes (hamachi)
O12-ncr53c406		bogus #if (ncr53c406)

Merged upstream:
B35-82596
B41-s390-phy
B44-genrtc
C33-mxser
C34-uli526x
C36-sunsu
S0-chelsio
S1-e1000
S2-s2io-iomem
S3-ipw2100
S10-ethtool

Updated:
S5-ahci
S7-sata_sx4
C39-s390
