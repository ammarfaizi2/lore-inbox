Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKURbU>; Tue, 21 Nov 2000 12:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQKURbK>; Tue, 21 Nov 2000 12:31:10 -0500
Received: from cs.rice.edu ([128.42.1.30]:11511 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id <S129150AbQKURa4>;
	Tue, 21 Nov 2000 12:30:56 -0500
From: Bradley Broom <broom@rice.edu>
To: malte@cornils.net
Subject: Re: tmscsim driver on test11-pre7 stops working when starting X
Date: Tue, 21 Nov 2000 10:38:25 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00112111010501.13138@dustbin.cs.rice.edu>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had a very similar problem testing the prepatch immediately before
test11 was released. I was running X but don't know if that's significant.

Hardware: tekram DC-390 controller, nvidia MX II card, XFree4.0.1, FIC-503+ MB,
AMD K6-III /400 processor, 128 Mbyte ram, 2 ne2k compatible nics, sb16.

I got similar error messages at the start (the Status of last IRQ line was the
same), but in my case the kernel kept looping, resetting the SCSI bus etc. etc.
all to no avail. Eventually I pressed the reset button.

Upon reboot, I'd lost the partition table and so couldn't boot.  I thought the
disk had gone, but it's actually OK. I'm now trying to find my old file systems
... (and I'll write down the partition table when I do).

I'm not subscribed to the list, so please cc me on any replies. I'm happy to
provide any additonal info, but I can't run anymore tests until I recover my
disk contents.

Regards,
Bradley.

-- 
Bradley Broom                              
Research Scientist,
Center for High Performance Software, Rice University.
Email: broom@rice.edu, Phone: 713-348-6220
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
