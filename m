Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUDPHMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 03:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUDPHMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 03:12:12 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:26792 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S262454AbUDPHML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 03:12:11 -0400
To: <linux-kernel@vger.kernel.org>
Subject: NFS export ... again
From: <fabian.frederick@prov-liege.be>
Date: Fri, 16 Apr 2004 09:05:50 +0200
Reply-To: <fabian.frederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.15]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S262454AbUDPHML/20040416071211Z+2733@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond, Chris,

     AFAICS, nfsd/export code already does some nfs cache poll through RPC to generate /proc/nfs/exports .... But content appears broken to me as it relates progressive mounting points but never umounts.We only have to fix this in my opinion ... or maybe I'm lured by multi-versioning there ... 

Regards,
Fabian

___________________________________



