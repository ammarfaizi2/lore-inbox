Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVJERff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVJERff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVJERff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:35:35 -0400
Received: from web35908.mail.mud.yahoo.com ([66.163.179.192]:3511 "HELO
	web35908.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030286AbVJERff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:35:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Vl+v1q9vm+AMW3NDJkIWg0TW6Y9p4iweR/1Ec9FIYOTWoedrAxGR70CyTsOSurw5sO6H4btMbPJSkBKsuqzVmzpGvSh8al/AKKWStIx8oQHnZETFgDQel94S7JfoZ4r5OVUAPpqzvmRWdqTSqLgMojpLN+pAXq6wOv3DuxTXUUU=  ;
Message-ID: <20051005173534.32907.qmail@web35908.mail.mud.yahoo.com>
Date: Wed, 5 Oct 2005 10:35:34 -0700 (PDT)
From: umesh chandak <chandak_pict@yahoo.com>
Subject: Kernel Panic Error in 2.6.10 !!!!
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
         I have compiled the kernel 2.6.10 with KGDB
patches on FC3 .My KGDB connetion are made correct .
I have copied bzImage and System.map on test machine .
but when i press C for continuig no devlopment m/c
after  connection are made.It gives me kernel panic
error like this 

VFS: Cannot open root device "hda6" or
unknown-block(3,6)
Please append a correct "root=" boot option Kernel
panic - not syncing: VFS: Unable to mount root fs on
unknown-block(3,6)
 

my root partion  is on /dev/hda6.
My grub entry is like this.


title 2.6.10 kgdb
         root (hd0,5)
         kernel /boot/vmlinuz-2.6.10 ro root=/dev/hda6
rootfstype=ext3 kgdbwait kgdb8250=1,57600


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
