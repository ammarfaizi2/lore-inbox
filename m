Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWILGWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWILGWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 02:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWILGWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 02:22:09 -0400
Received: from buick.jordet.net ([193.91.240.190]:27060 "EHLO buick.jordet.net")
	by vger.kernel.org with ESMTP id S1751324AbWILGWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 02:22:07 -0400
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Stian Jordet <liste@jordet.net>
To: Daniel Drake <dsd@gentoo.org>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, torvalds@osdl.org,
       jeff@garzik.org, greg@kroah.com, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru
In-Reply-To: <4505DAFA.20802@gentoo.org>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
	 <1157811641.6877.5.camel@localhost.localdomain>
	 <4502D35E.8020802@gentoo.org>
	 <1157817836.6877.52.camel@localhost.localdomain>
	 <45033370.8040005@gentoo.org>
	 <1157848272.6877.108.camel@localhost.localdomain>
	 <450436F1.8070203@gentoo.org>
	 <1157906395.23085.18.camel@localhost.localdomain>
	 <4504621E.5090202@gentoo.org>
	 <1157917308.23085.26.camel@localhost.localdomain>
	 <1157916102.21295.9.camel@localhost.localdomain>
	 <1157988809.13889.5.camel@localhost.localdomain>
	 <1158005769.4748.0.camel@localhost.localdomain> <4505DAFA.20802@gentoo.org>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 08:21:36 +0200
Message-Id: <1158042096.4277.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On man, 2006-09-11 at 17:54 -0400, Daniel Drake wrote:
> Stian Jordet wrote:
> >> if it is , was resolved with this [PATCH V3] VIA IRQ quirk behaviour change ? 
> > 
> > I have no idea what you mean here, but it's by no means fixed by that
> > patch, actually it just got worse (usb didn't work, but still got
> > interrupts from eth0 - and it still used irq 11)
> 
> Are you sure? The failure report you sent me was from V2 of the patch. 
> V3 should work fine, based on earlier comments and info from you.

Sorry, I was thinking of the wrong patch (the first one, which disabled
quirks for acpi). My wrong, sorry. With your last patch it works just
like it always has :)

Thanks!

-Stian

