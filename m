Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWBVM4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWBVM4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWBVM4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:56:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27817 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750720AbWBVM4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:56:20 -0500
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen hypervisor
	attributes to sysfs
From: Arjan van de Ven <arjan@infradead.org>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
In-Reply-To: <43FC5B1D.5040901@us.ibm.com>
References: <43FB2642.7020109@us.ibm.com>
	 <1140542130.8693.18.camel@localhost.localdomain>
	 <20060222123250.GB9295@osiris.boeblingen.de.ibm.com>
	 <43FC5B1D.5040901@us.ibm.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 13:56:09 +0100
Message-Id: <1140612969.2979.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 07:37 -0500, Mike D. Day wrote:
> Heiko Carstens wrote:
> >> You can also set the standard that any other hypervisor has to
> >> follow! :)
> > 
> > I doubt that there is much that different hypervisors can share.
> > Why should all this be visible for user space anyway? What's the purpose?
> 
> In Xen at least, hypervisor management and control programs run in user 
> space in a "privileged" domain (or virtual machine). Systems management 
> agents in user space on the privileged domain need to know this 
> information, and sysfs is a good place to expose it.


surely those tools already talk to the hypervisor.. so they might as
well ask for this information themselves... no need to bloat the kernel
for this


