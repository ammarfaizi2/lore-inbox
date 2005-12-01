Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVLAIIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVLAIIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 03:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbVLAIIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 03:08:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38306 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750775AbVLAIIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 03:08:05 -0500
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled
	adapters
From: Arjan van de Ven <arjan@infradead.org>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Chris McDermott <lcm@us.ibm.com>, Luvella McFadden <luvella@us.ibm.com>,
       AJ Johnson <blujuice@us.ibm.com>, Kevin Stansell <kstansel@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <438E90DD.3010007@us.ibm.com>
References: <438E90DD.3010007@us.ibm.com>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 09:08:01 +0100
Message-Id: <1133424481.2853.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Upon bootup, the aic79xx
> driver will grab both controllers even though I'd prefer that Adaptec's a320raid
> driver grab the HostRAID controller.  

where is the sourcecode for the a320raid driver?

afaik dmraid supports this format already, and if not I would urge you
to help the dmraid project to support it instead..


