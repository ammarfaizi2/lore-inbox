Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWBVMdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWBVMdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWBVMdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:33:00 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:62361 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751248AbWBVMc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:32:59 -0500
Date: Wed, 22 Feb 2006 13:32:50 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Mike D. Day" <ncmike@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen hypervisor attributes to sysfs
Message-ID: <20060222123250.GB9295@osiris.boeblingen.de.ibm.com>
References: <43FB2642.7020109@us.ibm.com> <1140542130.8693.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140542130.8693.18.camel@localhost.localdomain>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm wondering if this information couldn't be laid out in a slightly
> more generic way so that other hypervisors could use the same layout.
> Instead of:
> 
> +---sys
>         +---hypervisor
>                 +---xen
>                         +---version
>                         +---major
>                         +---minor
>                         +---extra
> 
> It could be:
> 
> +---sys
>         +---hypervisor
>                 +---type
> 		+---version
>                         +---major
>                         +---minor
>                         +---extra
> 
> Where cat /sys/hypervisor/type is 'xen'.  That way, if there are generic
> things about hypervisors to export here, any generic tools can find them
> without having to know exactly which hypervisor is running.
> 
> You can also set the standard that any other hypervisor has to
> follow! :)

I doubt that there is much that different hypervisors can share.
Why should all this be visible for user space anyway? What's the purpose?

Heiko
