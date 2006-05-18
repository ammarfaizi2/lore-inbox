Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWERUSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWERUSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWERUSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:18:31 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:1715 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751389AbWERUSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:18:30 -0400
Message-ID: <446CD6C1.6030705@cmu.edu>
Date: Thu, 18 May 2006 16:19:13 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-lvm@redhat.com
Subject: dm-mod unresolved external with 2.4.32
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering if anyone has gotten LVM2 support with the 2.4.32 kernel?

I downloaded device-mapper.1.01.05 and applied the 2.4.28-pre4-devmapper
and 2.4.22-VFS-lock patches to my 2.4.32 kernel, which seemed to be
successful

I then added module support for device mapper in the kernel, and did
make dep && make bzImage modules modules_install && make install

So then i reboot and I see "dm-mod.o: -1 Unresolved external symbol"

I had no errors or warnings building my modules

Any ideas how i can find out what the external symbol is, or does anyone
see anything I'm missing?

Thanks!
George
