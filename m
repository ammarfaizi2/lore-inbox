Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135939AbREBFIr>; Wed, 2 May 2001 01:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135931AbREBFIi>; Wed, 2 May 2001 01:08:38 -0400
Received: from [195.50.100.22] ([195.50.100.22]:3227 "HELO
	emasgn01.eu.rabobank.com") by vger.kernel.org with SMTP
	id <S133029AbREBFIU>; Wed, 2 May 2001 01:08:20 -0400
X-Server-Uuid: df2cf700-468c-11d4-860a-00508b951a52
Message-ID: <1E8992B3CD28D4119D5B00508B08EC5627E8A1@sinxsn02.ap.rabobank.com>
From: "Sim, CT (Chee Tong)" <CheeTong.Sim@sin.rabobank.com>
To: linux-kernel@vger.kernel.org
cc: linux-admin@vger.kernel.org
Subject: Linux NAT questions
Date: Wed, 2 May 2001 13:08:43 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 16F14AC818165-01-02
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


what I am trying to do is this. I have a genuine network, say 1.1.1.x, and
my Linux host is on it, as 1.1.1.252 (eth0). I also have a second network at
the back of the Linux box, 192.168.200.x, and a web server on that network,
192.168.200.2. The Linux address is 192.168.200.1 on eth1. 

What I want to do is make the web server appear on the 1.1.1.x network as
1.1.1.160. I have done this before with Firewall-1 on NT, by putting an arp
entry for 1.1.1.160 to point to the Linux machine eth0. The packets get
redirected into the Linux machine, then translated, and then routed out of
eth1. 

The benefit is that there is no routing change to the 1.1.1.x network, and
the Linux box isn't even seen as a router. 

I would appreciate any help with this. Any command to do this?  

Chee Tong


==================================================================
De informatie opgenomen in dit bericht kan vertrouwelijk zijn en 
is uitsluitend bestemd voor de geadresseerde. Indien u dit bericht 
onterecht ontvangt wordt u verzocht de inhoud niet te gebruiken en 
de afzender direct te informeren door het bericht te retourneren. 
==================================================================
The information contained in this message may be confidential 
and is intended to be exclusively for the addressee. Should you 
receive this message unintentionally, please do not use the contents 
herein and notify the sender immediately by return e-mail.


==================================================================

