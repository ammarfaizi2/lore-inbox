Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVKIWaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVKIWaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVKIWaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:30:55 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:30700 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1750971AbVKIWay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:30:54 -0500
Subject: Re: merge status
From: David Woodhouse <dwmw2@infradead.org>
To: Steven French <sfrench@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Ben Collins <bcollins@debian.org>, Dave Jones <davej@codemonkey.org.uk>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jeff Garzik <jgarzik@pobox.com>, "Brown, Len" <len.brown@intel.com>,
       linux-kernel@vger.kernel.org, Roland Dreier <rolandd@cisco.com>,
       Jody McIntyre <scjody@modernduck.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <OF4A6DAD74.A56B078E-ON872570B4.007A77CE-862570B4.007AC8BB@us.ibm.com>
References: <OF4A6DAD74.A56B078E-ON872570B4.007A77CE-862570B4.007AC8BB@us.ibm.com>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 22:23:50 +0000
Message-Id: <1131575030.27347.170.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 16:20 -0600, Steven French wrote:
> At the moment cifs does not have any infrastructure dependencies (unless
> you count minor changes to the cifs section of fs/Kconfig and a problem
> noticed trying to cancel d_notify requests), but I am trying to get a new
> upcall  in cifs (for callout to a helper utility to assist in kerberos
> authentication) coded in time - although it will be marked experimental.

Using the key management infrastructure? That has upcalls to obtain keys
already.

-- 
dwmw2


