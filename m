Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290615AbSBGRhe>; Thu, 7 Feb 2002 12:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290677AbSBGRhY>; Thu, 7 Feb 2002 12:37:24 -0500
Received: from mushroom.netcomsystems.com ([12.9.24.195]:63288 "EHLO
	exch-connector.netcomsystems.com") by vger.kernel.org with ESMTP
	id <S290615AbSBGRhR>; Thu, 7 Feb 2002 12:37:17 -0500
Message-ID: <9384475DFC05D2118F9C00805F6F263107ECA811@exchange1.netcomsystems.com>
From: "Perches, Joe" <joe.perches@spirentcom.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: want opinions on possible glitch in 2.4 network error reporti
	ng
Date: Thu, 7 Feb 2002 09:37:10 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I ran into a somewhat related issue on a 2.2.16 system, where I had an
app that 
>> was calling sendto() on 217000 packets/sec, even though the wire could
only 
>> handle about 127000 packets/sec. I got no errors at all in sendto, even
though 
>> over a third of the packets were not actually being sent. 

> That is correct UDP behaviour 

Do you think this is the correct PacketSocket/RAW behaviour?
How does one guarantee a send/sendto/write?
