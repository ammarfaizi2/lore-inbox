Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWBVMhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWBVMhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWBVMhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:37:53 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:6060 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751246AbWBVMhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:37:52 -0500
Message-ID: <43FC5B1D.5040901@us.ibm.com>
Date: Wed, 22 Feb 2006 07:37:49 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Dave Hansen <haveblue@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen hypervisor attributes
 to sysfs
References: <43FB2642.7020109@us.ibm.com> <1140542130.8693.18.camel@localhost.localdomain> <20060222123250.GB9295@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060222123250.GB9295@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens wrote:
>> You can also set the standard that any other hypervisor has to
>> follow! :)
> 
> I doubt that there is much that different hypervisors can share.
> Why should all this be visible for user space anyway? What's the purpose?

In Xen at least, hypervisor management and control programs run in user 
space in a "privileged" domain (or virtual machine). Systems management 
agents in user space on the privileged domain need to know this 
information, and sysfs is a good place to expose it.

Mike

-- 


