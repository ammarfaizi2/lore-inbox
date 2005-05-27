Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVE0DdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVE0DdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 23:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVE0DdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 23:33:13 -0400
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:24197 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S261867AbVE0Dc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 23:32:57 -0400
Message-ID: <429694D2.5000007@jg555.com>
Date: Thu, 26 May 2005 20:32:34 -0700
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: nfsroot question - laptop
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been playing around with the nfsroot in the 2.6 kernels, and I 
have come across something that seems to be quite odd.

I have two different architectures and 3 machines
    a RaQ2 - MIPS based, everything works great with nfsroot
    a x86 - Pentium II based server, everything works great with nfsroot
    a x86 - K6-2 Laptop

I have created a boot floppy with a kernel on it, with just the minimums 
to get the system up and running, this floppy is a grub based with a 
bzImage. As you will see below, I'm at the end of my diskspace.
Filesystem 1K-blocks      Used Available Use% Mounted on
/dev/fd0     1412              1271  69          95%   /media/floppy

Now for my question. If I setup nfsroot on my laptop, it never connects 
to the nfs server for the nfsroot, it bombs because it has to add the 
pcmcia sockets before the ethernet card can be activated. On the other 
x86 machine, it doesn't have the issue, since the driver doesn't depend 
a sockets driver.

Is this going to be fixed in the feature?
How can I get around this issue on the laptop?
Aren't Cardbus cards technically PCI?

-- 
----
Jim Gifford
maillist@jg555.com

