Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVAXEWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVAXEWo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 23:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVAXEWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 23:22:44 -0500
Received: from web60606.mail.yahoo.com ([216.109.118.244]:37209 "HELO
	web60606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261435AbVAXEWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 23:22:41 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=08iAFy8buwJtIlT4b+2zmJ7xx6xqaLN2SkMzKrc6Ay8a94dQgDCsmsXPpEqxSLG7li2aqoWDWmmDp8OaPQuvQWBe0OX+lWQ4Rp5nMgW1w4BKAIqy5eIxWL7W6ffRfS4nKU2JtTOiH8/dzMg6yaMocqouWVDglCO173c/G6mA/pE=  ;
Message-ID: <20050124042241.44427.qmail@web60606.mail.yahoo.com>
Date: Sun, 23 Jan 2005 20:22:41 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Help Regarding putting my module into the kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-experts,
     I am intercepting a few syscalls in kernel
2.4.28. My module name is rsched.c. To put it in the
kernel, I created a new subdirectory with the name
rsched under /linux-2.4.28 source directory. I created
the Makefile for it. I included the rsched
subdirectory in the list of  kernel subdirectories in
the toplevel Makefile as
  SUDIRS := (all-available subdirectories) rsched
     But when I build the kernel depmod showed the
following error:

  depmod: cannot read ELF header from
/lib/modules/2.4.28-rsched/kernel/rsched/rsched.o

   How can I correct it and add my module into the
kernel?
  Can anyone help me regarding this? I have also
attached the Makefile here.

Thanks,
selva

Makefile
--------
O_TARGET := rsched.o


obj-m   := $(O_TARGET)

include $(TOPDIR)/Rules.make
----------

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
