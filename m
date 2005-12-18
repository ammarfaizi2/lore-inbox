Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbVLRTwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbVLRTwO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbVLRTwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:52:14 -0500
Received: from lame.durables.org ([64.81.244.120]:21678 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S965257AbVLRTwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:52:13 -0500
Subject: Re: [PATCH 03/13] [RFC] ipath copy routines
From: Robert Walsh <rjwalsh@pathscale.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, rolandd@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051218.013341.34772534.davem@davemloft.net>
References: <20051217123833.1aa430ab.akpm@osdl.org>
	 <1134859243.20575.84.camel@phosphene.durables.org>
	 <20051217191932.af2b422c.akpm@osdl.org>
	 <20051218.013341.34772534.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 11:52:05 -0800
Message-Id: <1134935525.5826.0.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That would make sense.  Give it a non-ipath-related name and require that
> > all architectures which wish to run this driver must implement that
> > (documented) function.
> > 
> > And, in Kconfig, make sure that architectures which don't implement that
> > library function do not attempt to build this driver.  To avoid breaking
> > `make allmodconfig'.
> 
> How about we implement a portable version in C that you get
> by default if you don't implement the assembler routine?
> Pretty please? :-)

Sure.  :-)

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


