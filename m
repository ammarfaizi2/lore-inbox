Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278805AbRKFJXx>; Tue, 6 Nov 2001 04:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278701AbRKFJXo>; Tue, 6 Nov 2001 04:23:44 -0500
Received: from proxy1.braun.de ([193.17.96.34]:50389 "EHLO relay-ext.braun.de")
	by vger.kernel.org with ESMTP id <S278805AbRKFJXc>;
	Tue, 6 Nov 2001 04:23:32 -0500
Message-ID: <3BE7AC0F.6090804@gmx.de>
Date: Tue, 06 Nov 2001 10:23:27 +0100
From: Daniel =?ISO-8859-1?Q?Schr=F6ter?= <d.schroeter@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Win95; en-US; rv:0.9.5+) Gecko/20011030
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unresolved Symbol in 2.4.14 @block.o
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I get:

drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0xa58f): undefined reference to 
`deactivate_page'
drivers/block/block.o(.text+0xa5f4): undefined reference to 
`deactivate_page'
make: *** [vmlinux] Error 1

Is it the same Bug as the
[PATCH] Unresolved symbols in 2.4.14
from Craig Kulesa?

Where can I find the Patch? I didn't find in the kernel-archive the 
original posting from him. Just the answer from Linus Torwalds without 
the patch:-(
CU

