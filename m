Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266157AbSLOB5o>; Sat, 14 Dec 2002 20:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbSLOB5o>; Sat, 14 Dec 2002 20:57:44 -0500
Received: from ns1.triode.net.au ([202.147.124.1]:27549 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S266144AbSLOB5m>; Sat, 14 Dec 2002 20:57:42 -0500
Message-ID: <3DFBE3BE.5030209@torque.net>
Date: Sun, 15 Dec 2002 13:06:54 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jason Howard <""lists\"\"@spectsoft.com>
Subject: Re: DMA from SCSI controller to PCI frame buffer memory.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason wrote:
 > Any recommendations on where to start hacking?  Would
 > it be a good idea to add O_DIRECT to a mmaped PCI space?
 > The kernel should not be doing any buffering whatsoever,
 > as we will be coming close to filling the pci bus up
 > with transfers from direct disk->fb already.  (We are
 > already doing buffering on the FB card as well)

Jason,
Here is a less general solution that I worked on some
time ago involving the scsi generic driver.
   http://www.torque.net/sg/mem2disk.html

It worked ok for one application in the early 2.4 series.

Doug Gilbert

