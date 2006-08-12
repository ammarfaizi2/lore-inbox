Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422670AbWHLVBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbWHLVBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422687AbWHLVBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:01:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:17043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422686AbWHLVBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:01:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=HaD/fZXrxt9eVwhKM9sM7+YUhFpTKk5xXIKW0+TdQ8ck2ZXF91L3h8MgY8r3+Z/jh7pbTBCX8PbdETyiAEWpitOUKvWtRi373ebCQr4AK3/PwIkaEjaBt7YodNApdRmEMTZb6bDLeinVOJFDXNuJbPK9gj91HGIcqb9XgxOcCcQ=
Message-ID: <44DE41BD.4010203@gmail.com>
Date: Sat, 12 Aug 2006 23:01:49 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       Achim Leubner <achim_leubner@adaptec.com>, ipslinux@adaptec.com,
       GOTO Masanori <gotom@debian.or.jp>
Subject: [RFC] [PATCH 0/9] Removal of old scsi code
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes old scsi code.

The patches are against latest -mm snapshot.

dpt/dpti_i2o.h  |   10 ----
gdth.c          |  118 --------------------------------------------------------
gdth.h          |   10 ----
gdth_proc.c     |   27 ------------
ips.c           |  104 -------------------------------------------------
ips.h           |   28 -------------
nsp32.c         |   75 +----------------------------------
nsp32.h         |   42 -------------------
pcmcia/nsp_cs.h |   66 -------------------------------
9 files changed, 5 insertions(+), 475 deletions(-)

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)




