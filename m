Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135223AbRECVBX>; Thu, 3 May 2001 17:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135222AbRECVBD>; Thu, 3 May 2001 17:01:03 -0400
Received: from mail2.megatrends.com ([155.229.80.11]:4359 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S135217AbRECVBA>; Thu, 3 May 2001 17:01:00 -0400
Message-ID: <1355693A51C0D211B55A00105ACCFE6402B9DECF@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [RFC] Direct Sockets Support??
Date: Thu, 3 May 2001 16:55:57 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	>> technology is Infiniband . In Infiniband, the hardware supports
IPv6 . For
	>> this type of devices there is no need for software TCP/IP. But
for
	>> networking application, which mostly uses sockets, there is a
performance
	>> penalty with using software TCP/IP over this hardware. 

	> IPv6 is only the bottom layer of the stack. TCP does a lot lot
more.

	Sorry to have confused you. IB supports the notion of connection
over IPv6, not exactly TCP. I just interchanged TCP and notion of connection
provided by infiniband. Infiniband is a cluster of technologies like VI, IP,
etc. So i felt that we can take advantage of this to do networking. Because
the speed of IB ranges from 2.5Gbps to 30Gbps, even a slight overhead in
software will affect performance very badly.


