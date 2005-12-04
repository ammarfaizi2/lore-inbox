Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVLDPKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVLDPKo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVLDPKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:10:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26771 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932248AbVLDPKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:10:43 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: "M." <vo.sinh@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <f0cc38560512040657i58cc08efqa8596c357fcea82e@mail.gmail.com>
References: <20051203135608.GJ31395@stusta.de>
	 <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	 <20051203201945.GA4182@kroah.com>
	 <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com>
	 <20051203211209.GA4937@kroah.com>
	 <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com>
	 <1133645895.22170.33.camel@laptopd505.fenrus.org>
	 <f0cc38560512031353q27ee0a2dh70e283f53671b70f@mail.gmail.com>
	 <1133682973.5188.3.camel@laptopd505.fenrus.org>
	 <f0cc38560512040657i58cc08efqa8596c357fcea82e@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 16:10:38 +0100
Message-Id: <1133709038.5188.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-04 at 15:57 +0100, M. wrote:

> 
> if distros would align on those 6months versions those less
> experienced users would get 5 years support on those kernels. 

no distro gives 5 years of support for a kernel done every 6 months;
they start such projects more like every 18 to 24 months (SuSE used to
do it a bit more frequently but it seems they also slowed this down).

> example: redhat, suse and mandriva are releasing their new product
> using the latest 6months (or whatever) kernel; they are not going to
> patch it except for new filesystems or bugfixes because of the new dev

"except for" is a slipperly slope. And "except for bugfixes" would be
wrong... those would be the ones that need to be in the kernel.org
kernel. As well as new hardware support. At which point.. what is the
difference? Where do 'features' stop and where do 'only needed bugfixes'
begin?

>  model granting them all the needed new features; then, they start to
> mantain this kernel for their customers (and they could do it in a
> collaborative way, thus mantaining the kernel.org kernel plus their
> separate patches) and every user of redhat, suse, mandriva and the
> kernel.org 6months kernel they are using would benefit from this and
> would get 5 years support on this kernel.

that's not practical though. And it's still no better from the
regression point of view; those enterprise kernels undergo quite a bit
of churn as well, but just very directed churn to the point that I doubt
it would satisfy your target audience....

> 

