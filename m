Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135216AbREFIlA>; Sun, 6 May 2001 04:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135223AbREFIku>; Sun, 6 May 2001 04:40:50 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:43534 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id <S135216AbREFIkg>; Sun, 6 May 2001 04:40:36 -0400
Message-ID: <009701c0d599$c949e670$d55355c2@microsoft>
From: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>
To: <linux-kernel@vger.kernel.org>
Subject: RTL8139 problems
Date: Sat, 5 May 2001 23:30:04 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !
While working with RTL8139(C) based board I too often (5-10 min) get smth
like this :
Tx transmit timeout
Dirty Tx entry 001
---                  002
    ---              003
       ---           004
and than i need to restart interface to bring it really on (because, it
still not work after printk() smth Eth0 restarted)

Disabling MMIO don't give any results.

System:
    Chaintech 7AJA (VIA KT133, Latest bios)
    Duron 900
    Kernel 2.4.4 (8139too 0.9.16)

P.S. if I use old kernel 2.2.X and RTL81XX driver  I don't get this error
messages
                Alexander

