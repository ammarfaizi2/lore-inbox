Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTJEUWG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 16:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbTJEUWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 16:22:05 -0400
Received: from lewis.CNS.CWRU.Edu ([129.22.104.62]:27605 "EHLO
	lewis.CNS.CWRU.Edu") by vger.kernel.org with ESMTP id S263866AbTJEUWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 16:22:03 -0400
Date: Sun, 05 Oct 2003 16:21:06 -0400
From: Justin Hibbits <jrh29@po.cwru.edu>
Subject: regression between 2.4.18 and 2.4.21/22
To: linux-kernel@vger.kernel.org
Message-id: <7342FA76-F771-11D7-86F4-000A95841F44@po.cwru.edu>
MIME-version: 1.0
X-Mailer: Apple Mail (2.552)
Content-type: text/plain; format=flowed; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something very strange is going on with my machine.  With 2.4.18, I was 
getting 38MB/s on my main system disk (IBM Deskstar 60gxp), and 35 for 
the other drives (Western Digital).  The IBM drive is on a Promise IDE 
controller (ASUS A7V266-E motherboard), and the others are on a PROMISE 
2069 UDMA133 controller.  However, with 2.4.21 and 2.4.22, it will not 
set the using_dma flag for my IBM drive, but sets it for the others, 
which now get sustained transfer rates of 46MB/s or greater.  I'm using 
the same options for all 3 kernels (at least, for the ATA/IDE options). 
  Any help would be appreciated, and I'll see if maybe I could do 
something with it when I get time.

Thanks,

Justin

