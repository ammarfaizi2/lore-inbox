Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268279AbTBMUNC>; Thu, 13 Feb 2003 15:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268280AbTBMUNC>; Thu, 13 Feb 2003 15:13:02 -0500
Received: from f131.pav2.hotmail.com ([64.4.37.131]:270 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S268279AbTBMUNB>;
	Thu, 13 Feb 2003 15:13:01 -0500
X-Originating-IP: [129.219.25.77]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Exporting Kernel Symbols
Date: Thu, 13 Feb 2003 20:22:48 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F131jJLAiVXqMLhudPJ0001e073@hotmail.com>
X-OriginalArrivalTime: 13 Feb 2003 20:22:48.0848 (UTC) FILETIME=[AD2C4100:01C2D39D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have written a new function in linux/fs/read_write.c and I want to make 
the function avaliable to other kernel modules loaded using insmod.
He is what I did:
1. Wrore the func my_func() in linux/fs/read_write.c
2. Used the macro EXPORT_SYMBOL(my_func) inside linux/fs/read_write.c
3. Have a signature of my_func in my_func.h
4. Include my_func.h in linux/fs/read_write.c and my_driver.c
5. Recompiled the kernel
6. Compiler my_driver as loadable module.
7. Brought my new kernel Up.
8 . Insmod my_driver.o
Here I get the error "Unresolved symbol my_func"
Can any one clarify this.

Thanking You
Shesha





_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

