Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWHCDyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWHCDyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 23:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWHCDyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 23:54:53 -0400
Received: from ns.suse.de ([195.135.220.2]:33759 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932203AbWHCDyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 23:54:52 -0400
From: Andi Kleen <ak@suse.de>
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH 2 of 4] [x86-64] Calgary: only verify the allocation bitmap if CONFIG_IOMMU_DEBUG is on
Date: Thu, 3 Aug 2006 05:54:43 +0200
User-Agent: KMail/1.9.3
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
References: <patchbomb.1154559547@rhun.haifa.ibm.com> <515131a26b151f1e4596.1154559549@rhun.haifa.ibm.com> <20060803035723.GA7323@us.ibm.com>
In-Reply-To: <20060803035723.GA7323@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030554.43802.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +	BUG_ON(start > end);
> 
> This should be ">=".

Changed.

-Andi
