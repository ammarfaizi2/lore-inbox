Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbWALS7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbWALS7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWALS7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:59:31 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:20113 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932675AbWALS7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:59:30 -0500
Message-ID: <43C6A70D.8010902@us.ibm.com>
Date: Thu, 12 Jan 2006 12:59:25 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Greg KH <greg@kroah.com>, Gerd Hoffmann <kraxel@suse.de>,
       "Mike D. Day" <ncmike@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>	 <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>	 <43C5B59C.8050908@us.ibm.com> <43C65196.8040402@suse.de>	 <1137072089.2936.29.camel@laptopd505.fenrus.org> <43C66ACC.60408@suse.de>	 <20060112173926.GD10513@kroah.com>  <43C6A5B4.80801@us.ibm.com> <1137092120.2936.55.camel@laptopd505.fenrus.org>
In-Reply-To: <1137092120.2936.55.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Thu, 2006-01-12 at 12:53 -0600, Anthony Liguori wrote:
>  
>
>>We wish to make management hypercalls as the root user in userspace 
>>which means we have to go through the kernel.  Currently, we do this
>>by 
>>having /proc/xen/privcmd accept an ioctl() that takes a structure
>>that 
>>describe the register arguments.  The kernel interface allows us to 
>>control who in userspace can execute hypercalls.
>>    
>>
>
>ioctls on proc is evil though (so is ioctl-on-sysfs). It's a device not
>a proc file!
>  
>
I full heartedly agree with you :-)

Regards,

Anthony Liguori
