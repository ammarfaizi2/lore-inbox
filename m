Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274745AbRIZATE>; Tue, 25 Sep 2001 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274746AbRIZASy>; Tue, 25 Sep 2001 20:18:54 -0400
Received: from leg-64-133-146-200-RIA.sprinthome.com ([64.133.146.200]:29197
	"EHLO mail.pirk.com") by vger.kernel.org with ESMTP
	id <S274745AbRIZASq>; Tue, 25 Sep 2001 20:18:46 -0400
Date: Tue, 25 Sep 2001 17:17:50 -0700 (PDT)
From: Steve Pirk <orion@deathcon.com>
To: linux-kernel@vger.kernel.org
Subject: IP aliasing/Virtual IP's in 2.2.19 or 2.4.10
Message-ID: <Pine.LNX.4.21.0109251709280.964-100000@mail.pirk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember a while back that there was an option in make menuconfig
to enable IP masquerading or IP aliasing - The last version I
remember seeing it in was 2.2.16. I am trying to enable virtual
addresses on my box (eth0 and eth0:0 eth0:1 etc), and I am
getting the following errors:
SIOCSIFADDR: No such device
SIOCSIFFLAGS: No such device
when I issue the command:
/sbin/ifconfig eth0:0 64.133.146.201 broadcast 64.133.146.255 \
netmask 255.255.255.224

In the 2.2.16 menuconfig there was the following option inside of
Network Options:
[*] IP: masquerading
Enabling this allow me to define virtual IP's. I cannot find the
same option in 2.2.19, 2.4.4, or in 2.4.10. 
Does anyone know where/how to enable this much needed fuctionality?

Thansk in advance.
-- 
Steve Pirk
orion@deathcon.com . deathcon.com . pirk.com . webops.com . t2servers.com 

