Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130849AbQLMSoE>; Wed, 13 Dec 2000 13:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131055AbQLMSnx>; Wed, 13 Dec 2000 13:43:53 -0500
Received: from unassigned.wayout.net ([163.121.142.10]:19183 "EHLO
	thewayout.net") by vger.kernel.org with ESMTP id <S130849AbQLMSns>;
	Wed, 13 Dec 2000 13:43:48 -0500
From: khaled@pacificpost.com
Message-ID: <3A37BBE0.D6E93D0A@pacificpost.com>
Date: Wed, 13 Dec 2000 20:11:44 +0200
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TCP Filter
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux World,

I need to insert a TCP or socket filter that intercepts incoming
user-supplied buffers and do some processing on its contents if it
matches some criterion in the sender. The receiver should do similarly
in the reverse order on the other end of the connection.

I read the Linux Socket Filter Documentation and also the BPF packet
filter man pages and I am feeling that these facilities can not do what
is described above (but I am not sure). I want to use as much as
possible the facilities provided by the Linux Kernel. Ipchains/ipfw will
provide filtering on IP packets which is not what I would like to do. I
would like to intercept/filter traffic incoming into/going out a socket
descriptor through the read/write/send/recv system calls.

Please let me know what to read if what I want to do already exist in
the Socket Filter or other Linux kernel mechanisms.

Best regards

Khaled

PS: Please CC me on the replies since I am not a regular subscriber to
this list.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
