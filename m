Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312119AbSDXNJN>; Wed, 24 Apr 2002 09:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312134AbSDXNJM>; Wed, 24 Apr 2002 09:09:12 -0400
Received: from proxyserver.epcnet.de ([62.132.156.25]:52999 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S312119AbSDXNJM>; Wed, 24 Apr 2002 09:09:12 -0400
Date: Wed, 24 Apr 2002 15:09:09
From: jd@epcnet.de
To: linux-kernel@vger.kernel.org
Subject: VLAN and Network Drivers 2.4.x
MIME-Version: 1.0
Message-ID: <718111768.avixxmail@nexxnet.epcnet.de>
X-Priority: 3
X-Mailer: avixxmail 1.2.2.6
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: text/plain; charset="iso-8859-1";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

why is a there a experimental VLAN option in the stable 2.4.x-kernel, when it's useless without patching Network Drivers?

Why isn't there a solution for all network drivers to accept frames 4 bytes longer on request of e.g. vconfig (like ifconfig setting promiscious mode on/off) ? Or to deny vconfig to add a vlan, if the network driver/hardware doesn't support this?

Today the situation is as follows: The experimental VLAN-option is useless, if i dont patch my network drivers, otherwise there is no working VLAN function.

Any future plans?

