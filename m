Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVI1XaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVI1XaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVI1XaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:30:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2741
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751233AbVI1XaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:30:19 -0400
Date: Wed, 28 Sep 2005 16:29:29 -0700 (PDT)
Message-Id: <20050928.162929.50617923.davem@davemloft.net>
To: jgarzik@pobox.com
Cc: willy@w.ods.org, luben_tuikov@adaptec.com, andre@linux-ide.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <433B25CD.7040809@pobox.com>
References: <433B0374.4090100@adaptec.com>
	<20050928223542.GA12559@alpha.home.local>
	<433B25CD.7040809@pobox.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Wed, 28 Sep 2005 19:22:53 -0400

> Both Luben and his predecessor, Justin Gibbs, were severely dissatisfied 
> with the SCSI core.  Often they have raised valid issues that need 
> addressing, but their choice has been to work around or ignore existing 
> code (and maintainers), rather than work with it, and fix it.

I'm in violent agreement here.

Justin was just as anti-social of an engineer as one could get.  And,
when you put an ex-FreeBSD guy onto Linux driver maintainence, what in
the world could anyone expect. :-)

For example, instead of accepting that the symbol "current" is a
reserved symbol when compiling under the Linux kernel, he decided that
"sticking a square peg into a round hole" was a better way to deal
with this, and thus he put an "#undef current" into the adaptec driver
instead of simply renaming a structure member from "current" to
something else.

I don't know how else to define "control freak".
