Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWBBQcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWBBQcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWBBQcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:32:52 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:13783 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932145AbWBBQcv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:32:51 -0500
Message-ID: <43E239F0.4060903@us.ibm.com>
Date: Thu, 02 Feb 2006 10:57:20 -0600
From: Linda Xie <lxiep@us.ibm.com>
Reply-To: lxiep@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, zh-cn, zh
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Linda Xie <lxie@us.ibm.com>,
       John Rose <johnrose@austin.ibm.com>
Subject: Re: missing symbols on ppc64 in -git5
References: <20060201223308.GA8588@redhat.com>
In-Reply-To: <20060201223308.GA8588@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

It looks like git5 doesn't have the patches(Assorted PCI hotplug 
PRAPHP/DLAPR cleanup) that Linas submitted
several  weeks ago.


Linda
 
Dave Jones wrote:

>ppc64 builds got a bunch of new missing symbols..
>
>drivers/pci/hotplug/rpaphp.ko needs unknown symbol pcibios_add_pci_devices
>drivers/pci/hotplug/rpaphp.ko needs unknown symbol pcibios_find_pci_bus
>drivers/pci/hotplug/rpadlpar_io.ko needs unknown symbol rpaphp_deregister_slot
>drivers/pci/hotplug/rpadlpar_io.ko needs unknown symbol pcibios_find_pci_bus
>drivers/pci/hotplug/rpadlpar_io.ko needs unknown symbol pcibios_fixup_new_pci_devices
>
>		Dave
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


