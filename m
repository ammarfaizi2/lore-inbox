Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUCKNsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUCKNsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:48:06 -0500
Received: from smtp03.web.de ([217.72.192.158]:22022 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261317AbUCKNsD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:48:03 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Subject: Re: ACPI PM Timer vs. C1 halt issue
Date: Thu, 11 Mar 2004 14:46:52 +0100
User-Agent: KMail/1.5.4
Cc: Len Brown <len.brown@intel.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Dominik Brodowski <linux@brodo.de>
References: <404E38B7.5080008@gmx.de> <200403110115.36257.thomas.schlichter@web.de> <40502794.60907@gmx.de>
In-Reply-To: <40502794.60907@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403111446.53470.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 11. März 2004 09:47 schrieb Prakash K. Cheemplavam:
> Thomas Schlichter wrote:
> > you may try to boot with ACPI PM timer enabled but with the additional
> > boot option 'noapic'. If this also cools down your processor, you maybe
> > should try the attached patch....
>
> I am currently not using APIC, so above wouldn't make a difference.

I just thought you use an APIC because the .config you sent contains:
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

But you're right, if you don't use an APIC, my patch makes no difference...

   Thomas

