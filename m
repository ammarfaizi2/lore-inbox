Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTDYMlT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTDYMlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:41:19 -0400
Received: from copper.ftech.net ([212.32.16.118]:54403 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id S263926AbTDYMlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:41:17 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E25C899@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Loading Modules on Sparc64
Date: Fri, 25 Apr 2003 13:53:26 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I have installed Aurora 1.0 on a Sparc Ultra 60 workstation and have
a command line system running (X doesn't work yet but that's another
question for later).  

For sparc64 I realise that userland is 32 bits and Kernel space is 64 bits.
I have built a Kernel module in userland and I am trying to load it into the
Kernel.  I get the following error message:

[root@icarus kernel]# /sbin/insmod fred.o
fsx25.o: ELF file fred.o not for this architecture

I assume this is to do with the 32/64 bit issue.  What magic do I need to
place in my Makefile or tool do I need to use to build a module that can be
loaded.

I have spent a couple of hours searching with google but haven't found any
help in this matter.


Thanks


Kevin
