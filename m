Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292634AbSBQAgY>; Sat, 16 Feb 2002 19:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292635AbSBQAgP>; Sat, 16 Feb 2002 19:36:15 -0500
Received: from europa.capecodvacation.com ([199.232.149.139]:39175 "HELO
	europa.capecodvacation.com") by vger.kernel.org with SMTP
	id <S292634AbSBQAgD>; Sat, 16 Feb 2002 19:36:03 -0500
Date: Sat, 16 Feb 2002 19:35:51 -0500
To: linux-kernel@vger.kernel.org
Subject: xirc2ps_cs: transmit timed out
Message-ID: <20020217003551.GA1814@vger.capecodvacation.com>
Mail-Followup-To: jake@lucidpark.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: jake@lucidpark.net (Jacob Elder)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to use a XE2000 (Xircom 10/100 Network PC Card) in an older Dell
Latitude. The card comes up and does appear to be healthy that the link
light is always red and I can't see any traffic. I've never seen this card
work so I don't know if the link light color indicates a problem. About once
a minute, I see:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: tranmit timed out
eth0: media 10BaseT, silicon 4

(typed that in by hand)

The switch on the other end (Catalyst 2924) shows a normal 100bT fulldup
link light.  Running "tcpdump ether host $laptop_mac" from another host
shows nothing.

I am running 2.4.17, debian woody, pcmcia-cs 2.1.31-6.

I'm not subscribed to the list, please CC me on replies.

-- 
Jacob Elder
http://www.lucidpark.net/
