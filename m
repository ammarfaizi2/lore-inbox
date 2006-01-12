Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWALOwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWALOwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWALOwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:52:20 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:45217 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030431AbWALOwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:52:20 -0500
Message-ID: <43C66D12.5090503@us.ibm.com>
Date: Thu, 12 Jan 2006 09:52:02 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>	<43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>	<43C5B59C.8050908@us.ibm.com> <1137057022.5397.7.camel@localhost.localdomain>
In-Reply-To: <1137057022.5397.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Wed, 2006-01-11 at 20:49 -0500, Mike D. Day wrote:
> 
> There are definitely things that are exceedingly helpful.  However,
> there are at least two other hypervisor-ish things that I can think of
> which do the exact same kinds of things.  Perhaps it would be helpful to
> collaborate with them and produce a common interface. (uml, s390, maybe
> some of the powerpc hypervisors)

yes, that is a good idea.

>>Can the domain be migrated to another physical host?
>>What scheduler is Xen using (xen has plug-in 
>>schedulers)? All the actual information resides within the xen 
>>hypervisor, not the linux kernel.
> 
> Other than debugging and curiosity, why are these things needed?

Debugging is always a good reason :) but I'm specifically thinking of 
systems management tools, deployment of virtual machines, and migration. 
All of these attributes are important for tools that manage, deploy, or 
migrate.

thanks,

Mike


-- 

Mike D. Day
STSM and Architect, Open Virtualization
IBM Linux Technology Center
ncmike@us.ibm.com
