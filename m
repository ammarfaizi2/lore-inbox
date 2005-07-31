Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263194AbVGaAfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbVGaAfV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbVGaAfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:35:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21173
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263149AbVGaAeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:34:46 -0400
Date: Sat, 30 Jul 2005 17:34:53 -0700 (PDT)
Message-Id: <20050730.173453.130210989.davem@davemloft.net>
To: James.Bottomley@SteelEye.com
Cc: itn780@yahoo.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@lst.de
Subject: Re: [ANNOUNCE 0/7] Open-iSCSI/Linux-iSCSI-5 High-Performance
 Initiator
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1122755000.5055.31.camel@mulgrave>
References: <1122744762.5055.10.camel@mulgrave>
	<20050730.125312.78734701.davem@davemloft.net>
	<1122755000.5055.31.camel@mulgrave>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Sat, 30 Jul 2005 15:23:20 -0500

> Actually, I saw this and increased MAX_LINKS as well.

That does absolutely nothing, you cannot create sockets
with protocol numbers larger than NPROTOS which like MAX_LINKS
has the value 32.  And NPROTOS is something we cannot change.
