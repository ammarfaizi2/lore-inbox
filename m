Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135575AbRDTRgX>; Fri, 20 Apr 2001 13:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135734AbRDTRgN>; Fri, 20 Apr 2001 13:36:13 -0400
Received: from [194.65.138.12] ([194.65.138.12]:43528 "EHLO
	dominio_gestao.intra.cet.pt") by vger.kernel.org with ESMTP
	id <S135575AbRDTRgC> convert rfc822-to-8bit; Fri, 20 Apr 2001 13:36:02 -0400
Message-ID: <25CCC6566D01D411885B00A024559FB701486CC3@EXCHANGE_GERAL>
From: "Carlos Parada (EST)" <est-c-parada@ptinovacao.pt>
To: linux-kernel@vger.kernel.org, 6bone@ISI.EDU
Subject: IPv6 routing
Date: Fri, 20 Apr 2001 18:37:05 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm trying to set up an IPv6 network in Linux kernel 2.4.0-test10. In this
network I'm using just 3 boxs and I would use static routes.
 _____        _____          _____
|   A   |____|    B   | ____|   C   |     
|_____|       |_____|        |_____|

The problem is that I cannot access from A to C machines and vice-versa. But
the routing problem is a bit strange because, A can access to the two
interfaces of B, even to B interface in the same network as C. Also C can
access to both B interfaces and cannot access to machine A.
i.e. the machines seems that can access to other networks (the routing
mechanisms seems work fine), but B cannot be able to forward the packet. Is
this correct ?

Anybody know if I have a missconfiguration or I'm doing somethings wrong ?


Regards.

**********
Carlos da Fonseca Parada
PT Inovação, S.A.
Multimédia e Serviços IP

*   R. Engº José Ferreira Pinto Basto - 3810 Aveiro - Portugal
* Ext: 1317, 1318

