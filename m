Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbUJYRJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbUJYRJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUJYRHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:07:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33234 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261194AbUJYRFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:05:44 -0400
Message-ID: <417D325B.8060009@pobox.com>
Date: Mon, 25 Oct 2004 13:05:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Hanna Linder <hannal@us.ibm.com>
Subject: Compile breakage from me
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Argh, I thought GregKH had sent for_each_pci_dev()

Wearing a brown paper bag, can one of you please "cset -x" this changeset?

ChangeSet@1.2000.17.1, 2004-10-21 18:47:50-04:00, hannal@us.ibm.com
   [PATCH] hw_random.c: replace pci_find_device

   As pci_find_device is going away I've replaced it with pci_get_device.
   for_each_pci_dev is a macro wrapper around pci_get_device.
   If someone with this hardware could test it I would appreciate it.


