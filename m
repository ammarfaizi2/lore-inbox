Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265689AbUGGXtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUGGXtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 19:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUGGXtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 19:49:19 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30708 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265689AbUGGXtS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 19:49:18 -0400
Message-ID: <40EC9A02.1000507@us.ibm.com>
Date: Wed, 07 Jul 2004 19:49:06 -0500
From: Linda Xie <lxiep@us.ibm.com>
Reply-To: lxiep@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, zh-cn, zh
MIME-Version: 1.0
To: linas@austin.ibm.com
CC: greg@kroah.com, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] 2.6 PCI Hotplug: receive PPC64 EEH events
References: <20040707155907.G21634@forte.austin.ibm.com>
In-Reply-To: <20040707155907.G21634@forte.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas@austin.ibm.com wrote:

>  
>
>
> 	}
> 	sprintf(child_bus->name, "PCI Bus #%02x", child_bus->number);
> 	/* do pci_scan_child_bus */
>-	pci_scan_child_bus(child_bus);
>+	// pci_scan_child_bus(child_bus);
> 
>
>  
>
Why remove pci_scan_child_bus call?

Linda

