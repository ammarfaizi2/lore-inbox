Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWISRZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWISRZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWISRZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:25:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40405
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030370AbWISRZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:25:06 -0400
Date: Tue, 19 Sep 2006 10:24:36 -0700 (PDT)
Message-Id: <20060919.102436.82698995.davem@davemloft.net>
To: jmorris@namei.org
Cc: akpm@osdl.org, sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       vyekkirala@TrustedCS.com
Subject: Re: [PATCH] SELinux: Fix bug in security_sid_mls_copy
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0609191003100.17440@d.namei>
References: <Pine.LNX.4.64.0609190945180.17323@d.namei>
	<Pine.LNX.4.64.0609191003100.17440@d.namei>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morris <jmorris@namei.org>
Date: Tue, 19 Sep 2006 10:03:30 -0400 (EDT)

> On Tue, 19 Sep 2006, James Morris wrote:
> 
> > From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
> > 
> > The following fixes a bug where random mem is being tampered with in the 
> > non-mls case; encountered by Jashua Brindle on a gentoo box.
> > 
> > Please apply.
> 
> Actually, don't.  It's for the net-2.6.19 tree.

Applied to net-2.6.19, thanks.
