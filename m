Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272042AbTHHWeq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272059AbTHHWeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:34:46 -0400
Received: from fw1.masirv.com ([65.205.206.2]:700 "EHLO NEWMAN.masirv.com")
	by vger.kernel.org with ESMTP id S272042AbTHHWep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:34:45 -0400
Message-ID: <1060328695.9074.95.camel@huykhoi>
From: Anthony Truong <Anthony.Truong@mascorp.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Physically contiguous (DMA) memory allocation
Date: Fri, 8 Aug 2003 00:44:55 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm working on a driver for one of our devices with some heavy DMA
memory requirements - 20 - 30 MB in all.  As a loadable module (perfect
for development stage), the driver frequently causes annoying OOM
problems.
Is there a quick solution to this problem, like increasing the size of
the physically contiguous page pool (like in Windows NT and some other
OS'es :-( )? (Is it a good idea to make this one of the future
enhancements to Linux?)  Or should I write a driver loaded at boot time
grabbing the required memory pages and allocating them to my loadable
driver when requested?
Your suggestion is very much appreciated.

Regards,
Anthony Dominic Truong.





Disclaimer: The information contained in this transmission, including any
attachments, may contain confidential information of Matsushita Avionics
Systems Corporation.  This transmission is intended only for the use of the
addressee(s) listed above.  Unauthorized review, dissemination or other use
of the information contained in this transmission is strictly prohibited.
If you have received this transmission in error or have reason to believe
you are not authorized to receive it, please notify the sender by return
email and promptly delete the transmission.


