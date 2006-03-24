Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422816AbWCXNlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422816AbWCXNlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 08:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWCXNlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 08:41:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27342 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422787AbWCXNlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 08:41:13 -0500
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>, ian.pratt@cl.cam.ac.uk,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4423F60B.6020805@garzik.org>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
	 <4421D943.1090804@garzik.org>
	 <1143202673.18986.5.camel@localhost.localdomain>
	 <4423E853.1040707@garzik.org>  <4423F60B.6020805@garzik.org>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 14:40:56 +0100
Message-Id: <1143207657.2882.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 08:37 -0500, Jeff Garzik wrote:
> Jeff Garzik wrote:
> > In fact, SCSI should make a few things easier, because the notion of 
> > host+bus topology is already present, and notion of messaging is already 
> > present, so you don't have to recreate that in a Xen block device 
> > infrastructure.
> 
> Another benefit of SCSI:  when an IBM hypervisor in the Linux kernel 
> switched to SCSI, that allowed them to replace several drivers (virt 
> disk, virt cdrom, virt floppy?) with a single virt-SCSI driver.

but there's a generic one for that: iSCSI
so in theory you only need to provide a network driver then ;)



