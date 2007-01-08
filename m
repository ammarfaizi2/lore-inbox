Return-Path: <linux-kernel-owner+w=401wt.eu-S932667AbXAHU7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbXAHU7K (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbXAHU7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:59:10 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:42404 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932667AbXAHU7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:59:09 -0500
Message-ID: <45A2B099.5010701@linux.vnet.ibm.com>
Date: Mon, 08 Jan 2007 14:59:05 -0600
From: Anthony Liguori <aliguori@linux.vnet.ibm.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
MIME-Version: 1.0
To: Jeff Chua <jeff.chua.linux@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: KVM ... bypass BIOS check for VT?
References: <b6a2187b0612290714g4ce65aa2n82752ae73e651a38@mail.gmail.com>
In-Reply-To: <b6a2187b0612290714g4ce65aa2n82752ae73e651a38@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
> I'm resending this under KVM as a subject and hope to get response.
> 
> kvm: disabled by bios
> 
> I know this has been asked before and the answer was no. Does it still
> stand or is there a way to bypass the bios? I'm using Lenovo X60s and
> there's no option to enable VT in the BIOS setup.

There are two MSR bits involved in enabling VT.  The first bit 
enables/disables VT.  The second bit prevents the first bit from being 
changed until the next power up.

If the BIOS is setting the second bit while disabling the first bit, 
there's nothing that can be done to work around it.

Sorry.  Contact Lenovo and ask for a BIOS update.

Regards,

Anthony Liguori

> /proc/cpuinfo shows "VMX".
> 
> 
> Another question ... how to enable "mouse" in KVM?
> 
> 
> Thanks,
> Jeff.

