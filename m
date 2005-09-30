Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbVI3ORN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbVI3ORN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbVI3ORN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:17:13 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:29615 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030319AbVI3ORM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:17:12 -0400
Subject: Re: [patch] switch mtd to new driver model & cleanups
From: Josh Boyer <jdub@us.ibm.com>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: Pavel Machek <pavel@ucw.cz>, dwmw2@infradead.org,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
In-Reply-To: <433D482A.1000708@ru.mvista.com>
References: <20050930121741.GA5506@elf.ucw.cz>
	 <433D482A.1000708@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 09:17:07 -0500
Message-Id: <1128089827.3111.2.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 18:14 +0400, Vitaly Wool wrote:
> Hi Pavel,
> 
> it looks like your patch is not against the latest linux-mtd CVS sources 
> since there's no such things as mtd_pm_dev in the current one. Please 
> correct me if I'm mistaken.

I'm assuming Pavel is just fixing up what's in the mainline kernel.
This happens quite often, since MTD doesn't sync all too much for
various reasons.

When a sync is done, stuff like this usually gets picked up in some form
for the MTD CVS tree.  See the commit messages that say things like
"Merge with upstream".

josh

