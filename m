Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbREMN5O>; Sun, 13 May 2001 09:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbREMN4y>; Sun, 13 May 2001 09:56:54 -0400
Received: from [212.150.138.2] ([212.150.138.2]:62217 "EHLO
	ntserver.voltaire.com") by vger.kernel.org with ESMTP
	id <S261403AbREMN4u>; Sun, 13 May 2001 09:56:50 -0400
Message-ID: <20083A3BAEF9D211BDB600805F8B14F3AE379C@NTSERVER>
From: Aviv Greenberg <avivg@voltaire.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: TCP Segmentation Offload
Date: Sun, 13 May 2001 16:54:21 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

There is a nice feature (I saw it on 3Com EtherLink Server NIC cards)
called "TCP Segmentation Offload". Which means that the stack is presented 
with a larger MTU than eth, and the NIC produces smaller tcp segments.
More info at M$
http://www.microsoft.com/HWDEV/network/taskoffload.htm#Segment

I would like to hear your comments, weather this is something that can gain
real performance, and how to incorporate this into the Linux stack (At least
I didn't
see any references to it in kernel 2.4.(x<4)).

deca // sizeof(void)
