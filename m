Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTJOEIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 00:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTJOEI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 00:08:29 -0400
Received: from smtrly01.smartm.com ([158.116.149.131]:57093 "EHLO
	smtrly01.smartm.com") by vger.kernel.org with ESMTP id S262048AbTJOEI2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 00:08:28 -0400
Message-ID: <903E17B6FF22A24C96B4E28C2C0214D70104BDD7@sr-bng-exc01.int.tsbu.net>
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Daheriya, Adarsh" <Adarsh.Daheriya@fci.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: "Murray, Scott" <scott_murray@stream.com>,
       "Daheriya, Adarsh" <Adarsh.Daheriya@fci.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Hot Swap - Resource Allocation Problem.
Date: Wed, 15 Oct 2003 09:37:35 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-OriginalArrivalTime: 15 Oct 2003 04:07:18.0718 (UTC) FILETIME=[D34A2DE0:01C392D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Greg,

thanks for the reply.

i do reserve pci resources at boot time with kernel option as
"pci_hp_reserve=8,16,16" without quotes.
but still i am getting this problem.

is this problem coming because of mishandling of resources?

regards,
-Adarsh.

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Wednesday, October 15, 2003 2:19 AM
To: Daheriya, Adarsh
Cc: Murray, Scott; 'linux-kernel@vger.kernel.org'
Subject: Re: Hot Swap - Resource Allocation Problem.


On Tue, Oct 14, 2003 at 06:18:04PM +0530, Daheriya, Adarsh wrote:
> > hi Scott,
> > 
> > i am using your hot swap driver for one of our boards here. I have
> > back-ported the driver to 2.4.18 kernel.

For 2.4, I think that Scott had a patch that would require the user to
reserve pci resources at boot time to solve this problem.

See the linux pci hotplug devel mailing list archives for the patch and
a description of how to get this to work on 2.4.

Hope this helps,

greg k-h
