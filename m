Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWBVNGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWBVNGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWBVNGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:06:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:29635 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750791AbWBVNGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:06:17 -0500
Message-ID: <43FC61C4.30002@us.ibm.com>
Date: Wed, 22 Feb 2006 08:06:12 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen hypervisor	attributes
 to sysfs
References: <43FB2642.7020109@us.ibm.com>	 <1140542130.8693.18.camel@localhost.localdomain>	 <20060222123250.GB9295@osiris.boeblingen.de.ibm.com>	 <43FC5B1D.5040901@us.ibm.com> <1140612969.2979.20.camel@laptopd505.fenrus.org>
In-Reply-To: <1140612969.2979.20.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> surely those tools already talk to the hypervisor.. so they might as
> well ask for this information themselves... no need to bloat the kernel
> for this

Yes, it is an optional function. The current implementation is a module 
that can be omitted from the configuration, built-in, or loadable.

Mike
