Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbQLEMj1>; Tue, 5 Dec 2000 07:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbQLEMjR>; Tue, 5 Dec 2000 07:39:17 -0500
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:30473 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129718AbQLEMjA>; Tue, 5 Dec 2000 07:39:00 -0500
Date: Tue, 5 Dec 2000 12:04:10 +0000 (GMT)
From: Steve Hill <steve@navaho.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Serial Console
Message-ID: <Pine.LNX.4.21.0012051202120.1578-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm building boxes with the console set to /dev/ttyS0.  However, I can't
guarantee that there will always be a term plugged into the serial
port.  If there is no term on the port, eventually the buffer fills and
any processes that write to the console (i.e. init) block.  Is there some
option somewhere to stop this happening (i.e. either ignoring the
flow-control or just allowing the buffer to overflow)?

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
