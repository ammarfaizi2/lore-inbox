Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbUBEI2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 03:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUBEI2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 03:28:08 -0500
Received: from hermes.iil.intel.com ([192.198.152.99]:45723 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S264493AbUBEI2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 03:28:04 -0500
From: Amir Noam <amir.noam@intel.com>
To: "Bryan Whitehead" <driver@megahappy.net>, <ctindel@users.sourceforge.net>
Subject: Re: [Bonding-devel] [PATCH 2.6.2] drivers/net/bonding/bond_alb.c
Date: Thu, 5 Feb 2004 10:27:26 +0200
User-Agent: KMail/1.5.3
Cc: <bonding-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <E6F7D288B394A64585E67497E5126BA601F991D5@hasmsx403.iil.intel.com>
In-Reply-To: <E6F7D288B394A64585E67497E5126BA601F991D5@hasmsx403.iil.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402051027.26947.amir.noam@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 February 2004 01:33 am, Bryan Whitehead wrote:
> Building with gcc 3.3.2 on gentoo linux on Athlon x86 system I get
> a warning:
>   CC [M]  drivers/net/bonding/bond_alb.o
> drivers/net/bonding/bond_alb.c: In function `bond_alb_xmit':
> drivers/net/bonding/bond_alb.c:1340: warning: comparison is always
> true due to limited range of data
> type                                                               

I've sent out patches that fix this for both 2.4 and 2.6 about a month 
ago. The patches are in Jeff's netdev-2.* trees and will hopefully 
make their way upstream soon.

-- 
Amir

