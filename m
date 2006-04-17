Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWDQUJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWDQUJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWDQUJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:09:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38304
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750853AbWDQUJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:09:23 -0400
Date: Mon, 17 Apr 2006 13:08:21 -0700 (PDT)
Message-Id: <20060417.130821.119879392.davem@davemloft.net>
To: hch@infradead.org
Cc: sds@tycho.nsa.gov, edwin@gurde.com, linux-security-module@vger.kernel.org,
       jmorris@namei.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060417173319.GA11506@infradead.org>
References: <20060417162345.GA9609@infradead.org>
	<1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	<20060417173319.GA11506@infradead.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 17 Apr 2006 18:33:19 +0100

> On Mon, Apr 17, 2006 at 01:03:24PM -0400, Stephen Smalley wrote:
> > > fact for access control purposes is fundamentally flawed.  We're not going
> > > to add helpers or exports for it, I'd rather remove the ability to build
> > > lsm hook clients modular completely.
> > 
> > Or, better, remove LSM itself ;)
> 
> Seriously that makes a lot of sense.  All other modules people have come up
> with over the last years are irrelevant and/or broken by design.

I totally agree, let's get rid of LSM while we can.
