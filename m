Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422755AbWCXNha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWCXNha (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 08:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWCXNh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 08:37:29 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:40167 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932585AbWCXNh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 08:37:29 -0500
Message-ID: <4423F60B.6020805@garzik.org>
Date: Fri, 24 Mar 2006 08:37:15 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>, ian.pratt@cl.cam.ac.uk,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>	 <4421D943.1090804@garzik.org> <1143202673.18986.5.camel@localhost.localdomain> <4423E853.1040707@garzik.org>
In-Reply-To: <4423E853.1040707@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> In fact, SCSI should make a few things easier, because the notion of 
> host+bus topology is already present, and notion of messaging is already 
> present, so you don't have to recreate that in a Xen block device 
> infrastructure.

Another benefit of SCSI:  when an IBM hypervisor in the Linux kernel 
switched to SCSI, that allowed them to replace several drivers (virt 
disk, virt cdrom, virt floppy?) with a single virt-SCSI driver.

	Jeff


