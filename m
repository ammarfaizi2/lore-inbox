Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTDXLjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTDXLjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:39:25 -0400
Received: from [196.41.29.142] ([196.41.29.142]:57075 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263361AbTDXLjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:39:24 -0400
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
From: Martin Schlemmer <azarah@gentoo.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1051171042.1104.11.camel@flat41>
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
	 <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de>
	 <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
	 <20030421210020.A29421@lst.de>
	 <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
	 <20030421215637.A30019@lst.de>
	 <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
	 <1050957875.1224.2.camel@flat41>
	 <1051169958.3604.2619.camel@workshop.saharact.lan>
	 <1051171042.1104.11.camel@flat41>
Content-Type: text/plain
Organization: 
Message-Id: <1051184807.3604.2642.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 24 Apr 2003 13:46:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 09:57, Grzegorz Jaskiewicz wrote:

> Well, if you will read my post - i am trying to use _ONLY_ devfs,
> without any demons.

Ok, missed that.

> Those demons are provided just to keep backward
> compatbility (at least this is my opinion) and can be used without them.
> 

Well, not really.  Yes, it does support the compat symlinks, etc, but
you can do much more with devfsd than just that.  Setting the
permissions/ownership on node registration, autoloading of modules
if a node is accessed, etc is just a few.

> i don't like personaly any ideas about udevfs and others. We should get
> rid of min/maj nr of each device becouse each single program uses device
> by name indeed ! Having just devfs solves many problems and is very good
> thing. But, again - without any userspace demons.
> 

See above.

> Linus was always trying kernel as simple as it is possible, well - imho
> devfs is just one step forward to make it even simpler but without
> removing any of it functionality.
> 

I guess you could see the management of devfs being done in userspace
(devfsd) as keeping kernel side simple :P


Regards,
 
-- 
Martin Schlemmer


