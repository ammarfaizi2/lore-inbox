Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUCZX2a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 18:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUCZX2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 18:28:30 -0500
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:64496 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261439AbUCZX22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 18:28:28 -0500
Message-ID: <4064BC9B.1040306@blueyonder.co.uk>
Date: Fri, 26 Mar 2004 23:28:27 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.5-rc2-mm4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2004 23:28:28.0374 (UTC) FILETIME=[0AF94760:01C4138A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the same compile failure on -mm4 as I was on -mm3.
  HOSTCC  usr/gen_init_cpio
  CPIO    usr/initramfs_data.cpio
  GZIP    usr/initramfs_data.cpio.gz
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  CC      arch/x86_64/kernel/process.o
  CC      arch/x86_64/kernel/semaphore.o
  CC      arch/x86_64/kernel/signal.o
arch/x86_64/kernel/signal.c: In function `do_signal':
arch/x86_64/kernel/signal.c:426: warning: passing arg 2 of 
`get_signal_to_deliver' from incompatible poi
nter type
arch/x86_64/kernel/signal.c:426: error: too few arguments to function 
`get_signal_to_deliver'
make[1]: *** [arch/x86_64/kernel/signal.o] Error 1
make: *** [arch/x86_64/kernel] Error 2
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

