Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbWALTSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWALTSY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWALTSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:18:24 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:59370 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161195AbWALTSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:18:23 -0500
Message-ID: <43C6AB78.1040301@us.ibm.com>
Date: Thu, 12 Jan 2006 14:18:16 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Anthony Liguori <aliguori@us.ibm.com>, Gerd Hoffmann <kraxel@suse.de>,
       Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com> <43C65196.8040402@suse.de> <1137072089.2936.29.camel@laptopd505.fenrus.org> <43C66ACC.60408@suse.de> <20060112173926.GD10513@kroah.com> <43C6A5B4.80801@us.ibm.com> <20060112190845.GA13073@kroah.com>
In-Reply-To: <20060112190845.GA13073@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> 
> Why not do the same thing that the Cell developers did for their
> "special syscalls"?  Or at the least, make it a "real" syscall like the
> ppc64 developers did.  It's not like there isn't a whole bunch of "prior
> art" in the kernel today that you should be ignoring.

A hypercall syscall would be good in a lot of ways. For x86/x86_64 there 
are multiple hypervisors so we would need to make the syscall general 
enough to support more than one hypervisor.

Mike
-- 

Mike D. Day
STSM and Architect, Open Virtualization
IBM Linux Technology Center
ncmike@us.ibm.com
