Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWBVOCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWBVOCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWBVOCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:02:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6616 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751285AbWBVOCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:02:02 -0500
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen
	hypervisor	attributes to sysfs
From: Arjan van de Ven <arjan@infradead.org>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
In-Reply-To: <43FC6A86.90901@us.ibm.com>
References: <43FB2642.7020109@us.ibm.com>
	 <1140542130.8693.18.camel@localhost.localdomain>
	 <20060222123250.GB9295@osiris.boeblingen.de.ibm.com>
	 <43FC5B1D.5040901@us.ibm.com>
	 <1140612969.2979.20.camel@laptopd505.fenrus.org>
	 <43FC61C4.30002@us.ibm.com>
	 <20060222131918.GC9295@osiris.boeblingen.de.ibm.com>
	 <43FC6A86.90901@us.ibm.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 15:01:51 +0100
Message-Id: <1140616911.2979.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 08:43 -0500, Mike D. Day wrote:
> Heiko Carstens wrote:
> > On Wed, Feb 22, 2006 at 08:06:12AM -0500, Mike D. Day wrote:
> > 
> > If it's not needed, why include it at all?
> 
> Sorry for not being clear. It *is* needed for control tools and agents 
> running in the privileged domain. 

but again those tools and agents *already* have a way of talking to the
hypervisor themselves. Why can't they just first ask this info? Why does
that need to be in the kernel, in unswappable memory?


