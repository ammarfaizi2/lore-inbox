Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUA3Knr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 05:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUA3Knq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 05:43:46 -0500
Received: from h24-77-134-228.wp.shawcable.net ([24.77.134.228]:3332 "EHLO
	polgara") by vger.kernel.org with ESMTP id S262580AbUA3Kno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 05:43:44 -0500
From: Mathieu Allard <mathieu@opalescent.ca>
Reply-To: mathieu@opalescent.ca
To: linux-kernel@vger.kernel.org
Subject: crash when using dma for cdrom drive
Date: Fri, 30 Jan 2004 04:43:39 -0600
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401300443.39841.mathieu@opalescent.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an MSIDDR motherboard, model k7t266 pro2 ver. 2.0.

When I enable dma for my cdrom drive using hdparm /dev/hdc, dma is turned on.

However, when I try and access the drive, my computer crashes.

In a console this is the text that I see : 





dma timeout error : status=0x50 {Drive Ready SeekComplete}
ide-scsi : abort called for 1629
bad : scheduling while atomic !
call trace : 
******( a whole bunch of information is here)

and then something like hdc dma reset complete.





I have tested this with a different cdrom drive and a different ide cable and 
the same thing happens.
The cdrom is the only device on the ide chain.

I am running a vanilla linux kernel 2.6.1 and am using the via chipset driver.
Debian unstable is my distribution.

I have searched google to no avail.

I have looked at various bios options but none seem interesting.

Any help would be appreciated with this problem.

Thanks in advance.

Mathieu
