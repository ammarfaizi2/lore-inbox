Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbTLROVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbTLROVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:21:10 -0500
Received: from mail.dietlibc.org ([212.84.236.4]:64904 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265150AbTLROVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:21:06 -0500
Message-ID: <3FE1B7D0.7000307@convergence.de>
Date: Thu, 18 Dec 2003 15:21:04 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.0
References: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org> <20031217211516.2c578bab.akpm@osdl.org>
In-Reply-To: <20031217211516.2c578bab.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

> - Please report any problems to the appropriate mailing list.  If you do
>   not know which list to use, send the report to linux-kernel@vger.kernel.org
>   and it should reach the right person.  Some active subsystem mailing lists
>   are:
> 
> 	linux1394-devel@lists.sourceforge.net
> 	linux-xfs@oss.sgi.com
> 	linux-acpi@intel.com
> 	linux-scsi@vger.kernel.org
> 	ext2-devel@lists.sourceforge.net
> 	linux-usb-users@lists.sourceforge.net

Please use <linux-dvb@linuxtv.org> for everything related to the DVB 
subsystem and DVB drivers (ie. drivers/media/dvb).

I have a bunch of patches regarding the DVB subsystem and the various 
drivers here. They have accumulated because I did not want to disturb 
Linus with "misc fixes in driver foo" patches.

Additionally, we (ie. the LinuxTV.org project) are planning to remove 
all compiled-in firmware blobs and instead use the new firmware loading 
facilities. I have a patch for the firmware loading here, too.

Can you please tell me if and when I can send you these patches?

For your information: the DVB subsystem and the drivers are hosted at
http://linuxtv.org/cgi-bin/cvsweb.cgi/

The driver can be used under 2.4 and 2.6 as well and is used mainly in 
Europe. In the past, I simply sent the patches to lkml and Linus 
directly. Except Alan Cox and Christoph Hellwig apparently nobody cared 
about this, perhaps mainly because the DVB system does not affect any 
other subsystem.

CU
Michael.
(LinuxTV.org CVS maintainer)
