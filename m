Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281554AbRKUBbB>; Tue, 20 Nov 2001 20:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281555AbRKUBaw>; Tue, 20 Nov 2001 20:30:52 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:37647 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S281554AbRKUBag>; Tue, 20 Nov 2001 20:30:36 -0500
Message-Id: <4.3.2.7.2.20011120202550.00c239c0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 20 Nov 2001 20:30:34 -0500
To: linux-kernel@vger.kernel.org
From: David Relson <relson@osagesoftware.com>
Subject: Shared Memory Problem
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

A simple question, I believe ...

I built my own 2.4.15-pre7 kernel today and have a problem - I can't start 
httpd.  Whenever I try I get the following messages:

Nov 20 18:53:35 walnut httpd: Ouch! ap_mm_create(1048576, 
"/var/apache-mm/mm.1529") failed
Nov 20 18:53:35 walnut httpd: Error: MM: mm:core: failed to acquire shared 
memory segment (Function not implemented): OS: No such file or directory

Which kernel CONFIG symbol I have set wrong?

Thanks.

David

P.S. I do have CONFIG_TMPFS=y and the df command shows:

Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda6              4111268   1564388   2338040  41% /
/dev/sda1                15522      4266     10455  29% /boot
none                     63736         0     63736   0% /dev/shm

--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       Ann Arbor, MI 48103
www.osagesoftware.com          tel:  734.821.8800

