Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291289AbSBGUiy>; Thu, 7 Feb 2002 15:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291284AbSBGUih>; Thu, 7 Feb 2002 15:38:37 -0500
Received: from mushroom.netcomsystems.com ([12.9.24.195]:65368 "EHLO
	exch-connector.netcomsystems.com") by vger.kernel.org with ESMTP
	id <S291289AbSBGUhr>; Thu, 7 Feb 2002 15:37:47 -0500
Message-ID: <9384475DFC05D2118F9C00805F6F263107ECA812@exchange1.netcomsystems.com>
From: "Perches, Joe" <joe.perches@spirentcom.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: want opinions on possible glitch in 2.4 network error reporti
	ng
Date: Thu, 7 Feb 2002 12:37:41 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How does one guarantee a packet socket send/sendto/write?

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]
> > That is correct UDP behaviour 
> Do you think this is the correct PacketSocket/RAW behaviour?
Yes.
> How does one guarantee a send/sendto/write?
Easy, you use send() or write(). These work on stream protocol TCP/IP
where there is a "connection".
