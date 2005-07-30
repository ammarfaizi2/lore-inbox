Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbVG3LWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVG3LWz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 07:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbVG3LWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 07:22:55 -0400
Received: from delta.dds.nl ([213.196.11.20]:25515 "EHLO delta.dds.nl")
	by vger.kernel.org with ESMTP id S263030AbVG3LWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 07:22:55 -0400
From: Willem de Bruijn <wdb@few.vu.nl>
To: linux-kernel@vger.kernel.org
Subject: status of kernel memory debugging?
Date: Sat, 30 Jul 2005 13:23:27 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507301323.28083.wdb@few.vu.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

For a project in packet filtering (ffpf.sf.net) I'm in the process of 
debugging kernel code I wrote. I have the habit of running all userspace code 
through valgrind, and have setup user-mode-linux to do the same with the 
kernel. 

Reading through some old LKML threads I see that there has been talk of 
valgrinding a UML image, but the outcome appears inconclusive. Could someone 
please update me on the status of memory debugging in the kernel, especially 
regarding valgrind?

Do you have other tools you regularly use, or is is simply a trial-and-error 
practice? Note that I already export my kernelspace code to userspace for 
unit-testing where possible. It is only in the ioctl/syscall handlers that 
this technique fails.

thanks,

  Willem de Bruijn
