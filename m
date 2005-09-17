Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVIQRtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVIQRtT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 13:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVIQRtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 13:49:19 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:58398 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1750715AbVIQRtS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 13:49:18 -0400
Date: Sat, 17 Sep 2005 19:49:17 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
In-Reply-To: <Pine.BSO.4.62.0509171707410.5000@rudy.mif.pg.gda.pl>
Message-ID: <Pine.BSO.4.62.0509171945280.5000@rudy.mif.pg.gda.pl>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
 <20050915.133026.21581824.davem@davemloft.net> <Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
 <20050916.155919.41629794.davem@redhat.com> <Pine.BSO.4.62.0509171707410.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1434987158-1126979357=:5000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1434987158-1126979357=:5000
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 17 Sep 2005, Tomasz K³oczko wrote:
[..]

Something new.
I'm just finish rewrite backup procedure from dumping to NFS volume to
using piped dump|ssh|dd.
During this happens:

PSYCHO0: Uncorrectable Error, primary error type[DMA Write]
PSYCHO0: bytemask[0000] dword_offset[7] UPA_MID[1f] was_block(1)
PSYCHO0: UE AFAR [000000005c8bc040]
PSYCHO0: UE Secondary errors [(DMA Write)]
PSYCHO0: IOMMU Error, type[Protection Error]

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1434987158-1126979357=:5000--
