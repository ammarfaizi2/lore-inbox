Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281153AbRKTQLF>; Tue, 20 Nov 2001 11:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281155AbRKTQKz>; Tue, 20 Nov 2001 11:10:55 -0500
Received: from tbird2.auc.ca ([199.212.53.2]:45322 "HELO tbird2.auc.on.ca")
	by vger.kernel.org with SMTP id <S281153AbRKTQKf>;
	Tue, 20 Nov 2001 11:10:35 -0500
Subject: File size limit exceeded with mkfs
From: Jason Tackaberry <tack@auc.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 20 Nov 2001 11:02:18 -0500
Message-Id: <1006272138.1263.3.camel@somewhere.auc.ca>
Mime-Version: 1.0
X-Spam-Rating: tbird2.auc.ca 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.  Please CC any responses to me as I'm not subscribed to
this list.

I just installed a shiny new 80GB disk as primary slave and decided to
upgrade to 2.4.14+ext3 patch.  It appears that with this kernel, and
also with 2.4.15-pre7, when trying to mkfs partitions greater than 2GB,
I get "file size limit exceeded" and mkfs aborts.  I can successfully
mkfs partitions <= 2GB.

I do not have this problem with 2.4.7; all works well.  Wondering if the
difference was ext3, I tried compiling 2.4.15-pre7 without ext3 support
and the same problem occured.

The disk is

   hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63

on a dual PIII-800 (SMP kernel).  Please let me know if I can supply
additional information.

Cheers,
Jason.

-- 
Academic Computing Support Specialist         Assistant Section Editor
Algoma University College                     http://linux.com/develop
Sault Ste. Marie, Ontario                 
705-949-2301 x330                                   Personal Home Page
http://www.auc.ca                                     http://sault.org

