Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129426AbRBPSQP>; Fri, 16 Feb 2001 13:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129317AbRBPSQG>; Fri, 16 Feb 2001 13:16:06 -0500
Received: from jkd.penguinfarm.com ([12.32.79.69]:12416 "HELO
	jkd.penguinfarm.com") by vger.kernel.org with SMTP
	id <S129426AbRBPSPv>; Fri, 16 Feb 2001 13:15:51 -0500
Message-ID: <3A8D6E23.77D1891D@penguinfarm.com>
Date: Fri, 16 Feb 2001 13:14:59 -0500
From: Jason Straight <junfan@penguinfarm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: (2.4.1-ac15) pcmcia irq conflict
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrading from 2.2.18 and 2.4.0 to 2.4.1-ac15 broke pcmcia.

I have a Dell Inspiron 8000. Trying to use pcmcia with kernel
(yenta_socket) or pcmcia-cs only causes pcmcia card to take irq 11,
which my eth device is on also. This didn't happen with 2.2 or 2.4.0
kernels.

What param would I pass (how can I specify) to get yenta_socket to take
say IRQ 9 or 10 on startup?

Thanks

-- 
Jason Straight
