Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVFUOH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVFUOH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVFUOEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:04:23 -0400
Received: from mail.harcroschem.com ([208.188.194.242]:51208 "EHLO
	kcdc1.harcros.com") by vger.kernel.org with ESMTP id S261326AbVFUOCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:02:52 -0400
Message-ID: <D9A1161581BD7541BC59D143B4A06294021FAA68@KCDC1>
From: "Hodle, Brian" <BHodle@harcroschem.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: FW: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Date: Tue, 21 Jun 2005 08:58:10 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Hodle, Brian 
Sent: Tuesday, June 21, 2005 8:53 AM
To: 'Peter Buckingham'
Subject: RE: PROBLEM: Devices behind PCI Express-to-PCI bridge not
mapped


Peter,
	I am experiencing exactly the same problem. I am using an ASUS
K8N-DL MB with the x86_64 kernel. My PCIX devices are not allocated
correctly. I tried using the  'pci=routeirq' option to no avail. Disabling
ACPI in the BIOS does not help the situation either. X will not use my PCIX
for GLX since none of the  extra txture memory has been allocated! Anyone
have any ideas?

regards,

Brian

-----Original Message-----
From: Peter Buckingham [mailto:peter@pantasys.com]
Sent: Monday, June 20, 2005 4:31 PM
To: Ivan Kokshaysky
Cc: sean.bruno@dsl-only.net; koch@esa.informatik.tu-darmstadt.de;
torvalds@osdl.org; benh@kernel.crashing.org;
linux-pci@atrey.karlin.mff.cuni.cz; linux-kernel@vger.kernel.org;
gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not
mapped


Hi Ivan,

I've just tried a recent pull from Linus post 2.6.12. It seems that the 
bar sizes are now (mostly) correct. However, there are still issues with 
the resources failing to be allocated and the bars being disabled. I've 
attached the latest dmesg and lspci -vvx to see whether there's any 
enlightenment out there...

thanks,

peter
