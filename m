Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVLQWrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVLQWrQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 17:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVLQWrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 17:47:15 -0500
Received: from lame.durables.org ([64.81.244.120]:31637 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S964991AbVLQWrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 17:47:15 -0500
Subject: Re: [PATCH 01/13]  [RFC] ipath basic headers
From: Robert Walsh <rjwalsh@pathscale.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Roland Dreier <rolandd@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1134858323.2997.11.camel@laptopd505.fenrus.org>
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
	 <200512161548.aLjaDpGm5aqk0k0p@cisco.com>
	 <20051217131456.GA13043@infradead.org>
	 <1134857953.20575.59.camel@phosphene.durables.org>
	 <1134858323.2997.11.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 14:47:12 -0800
Message-Id: <1134859632.20575.92.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and opterons can already run 2 architectures. And the HT bus is a
> generic bus.. with public specs. Others than just AMD use it as well.
> 
> also.. what is wrong with memcpy and co ?

Our chips can only handle double-word writes.  memcpy isn't guaranteed
to do this.

> then you need to use readl() and family most like; they already take
> care of this anyway.

Oh, OK then.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


