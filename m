Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbRFYIoy>; Mon, 25 Jun 2001 04:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbRFYIoo>; Mon, 25 Jun 2001 04:44:44 -0400
Received: from mail.uni-magdeburg.de ([141.44.1.10]:20679 "EHLO
	mail.uni-magdeburg.de") by vger.kernel.org with ESMTP
	id <S262685AbRFYIog>; Mon, 25 Jun 2001 04:44:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hendrik Muhs <Hendrik.Muhs@Student.Uni-Magdeburg.DE>
To: linux-kernel@vger.kernel.org
Subject: strange network problem
Date: Mon, 25 Jun 2001 10:49:22 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01062510492200.01640@tux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i have a strange network problem with smbfs and my local network

I am connected(100Mbit) with my local Samba Server (192.168.0.1), mounted two 
shares. 

If I download something the network connections breaks radomly (the traffic 
slows down to zero).
!But I have no kernel messages and no messages in my Samba-Log-files.!
If I do a ping(or something similar) to the server the network is up, the 
download goes on.
I could reproduce this bug with kernel 2.4.5 and 2.4.4 but not with 2..4.3 
and 2.4.2. 

My network card is a Realtek 8139 (driver: 8139too)

With a ne2000-card (only 10Mbit) I could not reproduce this bug.

So I don't know if this is a problem with the network-driver or with smbf and 
100 Mbit network. 

There must be something with the changes between 2.4.3 and 2.4.4

For more information please contact me. This is my first bug report do not 
blame me so hard. ;-)

Please CC me, because I am not subscribed to this mailing list.

Hendrik
