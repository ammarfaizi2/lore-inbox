Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbQKNMF7>; Tue, 14 Nov 2000 07:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130763AbQKNMFs>; Tue, 14 Nov 2000 07:05:48 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:25098 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130108AbQKNMFf>; Tue, 14 Nov 2000 07:05:35 -0500
X-Mailer: exmh version 2.0.2+CL 2/24/98
To: linux-kernel@vger.kernel.org
cc: Ian.Grant@cl.cam.ac.uk, mingo@elte.hu
Subject: RAID modules and CONFIG_AUTODETECT_RAID
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Nov 2000 11:35:33 +0000
From: Ian Grant <Ian.Grant@cl.cam.ac.uk>
Message-Id: <E13veNB-0000Se-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.2.x we were able to build a kernel with RAID modules and have it 
autodetect RAID partitions at boot time - so we could use raid root partitions.

In 2.40 the configuration option CONFIG_AUTODETECT_RAID is explicitly disabled 
unless at least one RAID module is built into the kernel.  I presume there is 
a good reason for this and that it's not just a mistake.

Are there any plans to re-enable this feature?  It would be nice to be able to 
have a single kernel for all our machines without having to have RAID in the 
kernel when it isn't needed.


-- 
Ian Grant, Computer Lab., New Museums Site, Pembroke Street, Cambridge
Phone: +44 1223 334420          Personal e-mail: iang at pobox dot com 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
