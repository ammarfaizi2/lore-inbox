Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbSJ1AUq>; Sun, 27 Oct 2002 19:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSJ1AUq>; Sun, 27 Oct 2002 19:20:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45575 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262788AbSJ1AUp>;
	Sun, 27 Oct 2002 19:20:45 -0500
Message-ID: <3DBC8440.4030603@pobox.com>
Date: Sun, 27 Oct 2002 19:26:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
References: <3DBB1150.2030800@pobox.com> <20021026152043.A13850@lucon.org> <3DBB1743.6060309@pobox.com> <20021026155342.A14378@lucon.org> <3DBB1E29.5020402@pobox.com> <20021026165315.A15269@lucon.org> <3DBB2BE7.70208@pobox.com> <3DBB2DB9.3000803@pobox.com> <20021026172526.A15641@lucon.org> <20021027174249.GA12811@kroah.com> <20021027124248.A8019@lucon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. J. Lu wrote:

>On Sun, Oct 27, 2002 at 09:42:49AM -0800, Greg KH wrote:
>  
>
>>On Sat, Oct 26, 2002 at 05:25:26PM -0700, H. J. Lu wrote:
>>    
>>
>>>On Sat, Oct 26, 2002 at 08:05:13PM -0400, Jeff Garzik wrote:
>>>      
>>>
>>>>Jeff Garzik wrote:
>>>>
>>>>        
>>>>
>>>>>s/__devinit/__init/ and the implementation looks ok to me
>>>>>          
>>>>>
>>>>
>>>>...except if your patch can be called in hotplug paths...
>>>>        
>>>>
>>>There are plenty of __devini in arch/i386/kernel/pci-pc.c. I will leave
>>>mine alone.
>>>      
>>>
>>That is because those functions can be called in PCI hotplug paths,
>>since yours is only called during init, it should be marked as such.
>>
>>    
>>
>
>Are you telling me that pcibios_sort will be called by PCI hotplug?
>  
>

no, he's saying __init is correct, as Alan and I said.

    Jeff





