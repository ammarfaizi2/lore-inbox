Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290816AbSBLHjF>; Tue, 12 Feb 2002 02:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290815AbSBLHi7>; Tue, 12 Feb 2002 02:38:59 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:31405 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290817AbSBLHiq>; Tue, 12 Feb 2002 02:38:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Joachim.Franek@t-online.de (Joachim Franek)
Reply-To: joachim.franek@t-online.de
To: linux-kernel@vger.kernel.org
Subject: Question: ifconfig, ip and ethernet driver module
Date: Tue, 12 Feb 2002 08:33:56 +0100
X-Mailer: KMail [version 1.3.1]
Organization: IBJF
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16aXWK-0zl82CC@fwd02.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question about the  location, the ip number is stored.
Kernel 2.4.x.

Assume there is a ethernet driver module eth.o. With
insmod eth.o there is eth1 available and with
ifconfig eth1 192.168.10.12 up 
the interface is operational.

ifconfig calls the code of the function:
int eth_open(struct net_device *dev)

And at this time I want to know  the parameter
of ifconfig.

my_network= ???   (Result: 192*256*256 + 168*156 + 10)
my_ip= ??? (Result: 12)
(assuming a netmask of 24 bits)

Thanks.

Joachim Franek
www.de-franek.de
rs485.de-franek.de
