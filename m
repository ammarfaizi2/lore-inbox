Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269681AbUJAHrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269681AbUJAHrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 03:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269723AbUJAHrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 03:47:53 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38588 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269681AbUJAHru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 03:47:50 -0400
Date: Fri, 01 Oct 2004 16:49:27 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [ACPI] [PATCH] Updated patches for PCI IRQ resource deallocation
 support [2/3]
In-reply-to: <Pine.LNX.4.61.0409301601240.3069@musoma.fsmlabs.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartmann <greg@kroah.com>, Len Brown <len.brown@intel.com>,
       tony.luck@intel.com, acpi-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org
Message-id: <415D0C07.2070806@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <Pine.LNX.4.53.0409251356110.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251401560.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251416570.2908@musoma.fsmlabs.com>
 <4157A9D7.4090605@jp.fujitsu.com>
 <Pine.LNX.4.61.0409281702580.3052@musoma.fsmlabs.com>
 <415A28B9.6080504@jp.fujitsu.com>
 <Pine.LNX.4.61.0409291809270.3056@musoma.fsmlabs.com>
 <415B8A16.9070101@jp.fujitsu.com>
 <Pine.LNX.4.61.0409301601240.3069@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> 
> Can't you declare "extern void acpi_unregister_gsi(int gsi)" in 
> include/asm/acpi.h? That way it stays arch specific and you don't have the 
> conflicting declarations. You can also move acpi_unregister_gsi into arch 
> specific headers too.
> 

OK. I'll update my patch based on your feedback.

Thanks,
Kenji Kaneshige

