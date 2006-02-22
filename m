Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWBVNnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWBVNnk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWBVNnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:43:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:44945 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750713AbWBVNnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:43:39 -0500
Message-ID: <43FC6A86.90901@us.ibm.com>
Date: Wed, 22 Feb 2006 08:43:34 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Arjan van de Ven <arjan@infradead.org>, Dave Hansen <haveblue@us.ibm.com>,
       xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen hypervisor	attributes
 to sysfs
References: <43FB2642.7020109@us.ibm.com> <1140542130.8693.18.camel@localhost.localdomain> <20060222123250.GB9295@osiris.boeblingen.de.ibm.com> <43FC5B1D.5040901@us.ibm.com> <1140612969.2979.20.camel@laptopd505.fenrus.org> <43FC61C4.30002@us.ibm.com> <20060222131918.GC9295@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060222131918.GC9295@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens wrote:
> On Wed, Feb 22, 2006 at 08:06:12AM -0500, Mike D. Day wrote:
> 
> If it's not needed, why include it at all?

Sorry for not being clear. It *is* needed for control tools and agents 
running in the privileged domain. Kernels running in unprivileged 
domains will not use the module.

Mike
