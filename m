Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261388AbRERSWb>; Fri, 18 May 2001 14:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbRERSWV>; Fri, 18 May 2001 14:22:21 -0400
Received: from mail.netscreen.com ([63.126.135.15]:25478 "EHLO
	mail.netscreen.com") by vger.kernel.org with ESMTP
	id <S261388AbRERSWL>; Fri, 18 May 2001 14:22:11 -0400
Message-ID: <A33AEFDC2EC0D411851900D0B73EBEF766DCDC@NAPA>
From: Hua Ji <hji@netscreen.com>
To: linux-kernel@vger.kernel.org
Subject: FW: About swapper_page_dir and processes' page directory
Date: Fri, 18 May 2001 11:19:23 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Folks,

Get a question today. Thanks in advance.

As we know, vmalloc and other memory allocation/de-allocation will
change/update
the swapper_page_dir maintain by the kernel. 

I am wondering when/how the kernel synchronzie the change to user level
processes' page
directory entries from the 768th to the 1023th.

Those entries get copied from swapper_page_dir when a user process get
forked/created. Does the kernel
frequently update this information every time when the swapper_page_dir get
changed?

Regards,

Mike
 
