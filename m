Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266842AbSLKAIp>; Tue, 10 Dec 2002 19:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266846AbSLKAIp>; Tue, 10 Dec 2002 19:08:45 -0500
Received: from f155.law8.hotmail.com ([216.33.241.155]:22281 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266842AbSLKAIo>;
	Tue, 10 Dec 2002 19:08:44 -0500
X-Originating-IP: [207.35.78.2]
From: "Wahib Nackad" <wahibn@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: is not plain file nor directory
Date: Wed, 11 Dec 2002 00:16:25 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F155L9OqNHKEn8diHNK0001ecdb@hotmail.com>
X-OriginalArrivalTime: 11 Dec 2002 00:16:25.0271 (UTC) FILETIME=[8AC2EC70:01C2A0AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm able to compile kernel 2.4.20 via SRPMS with spec file without problem 
as long as I don't enable pcmcia support with the kernel. If I enable pcmcia 
support, then compilation fail when the 'make module_install' command runs 
and return the following error message for each pcmcia drivers:

depmod: 
/var/tmp/kernel-2.4.20-root/lib/modules/2.4.20-1/pcmcia/xircom_tulip_cb.o is 
not plain file nor directory

The /var/tmp/kernel-2.4.20-root/lib/modules/2.4.20-1/pcmcia is a directory 
created by the 'make module_install' command with all pcmcia drivers made as 
symbolic link inside it. Those symbolic links point to the right 
subdirectory under the kernel directory but it seem to me that the system or 
something else do not want to follow the symbolic link and this is why I 
receive the "is not plain file nor directory" error.

Can someone exlain me how to fix this?

Thanks a lot.
W





_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*. 
http://join.msn.com/?page=features/virus

