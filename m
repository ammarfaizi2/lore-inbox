Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269851AbRHIQKA>; Thu, 9 Aug 2001 12:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269852AbRHIQJv>; Thu, 9 Aug 2001 12:09:51 -0400
Received: from tiku.hut.fi ([130.233.228.86]:32782 "EHLO tiku.hut.fi")
	by vger.kernel.org with ESMTP id <S269851AbRHIQJn>;
	Thu, 9 Aug 2001 12:09:43 -0400
Date: Thu, 9 Aug 2001 19:09:53 +0300 (EET DST)
From: =?ISO-8859-1?Q?Janne_P=E4nk=E4l=E4?= <epankala@cc.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: linux-2.2.19 masquerading and always_defrag
In-Reply-To: <20010808195133.A22469@lightning.swansea.linux.org.uk>
Message-ID: <Pine.OSF.4.10.10108091906350.16080-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone else noticed that with 2.2.19 kernel the value of 
/proc/sys/net/ipv4/ip_always_defrag 'floats' if you do masqueraded access
trough the machine.

one can echo it to 1 and then it starts floating anywhere between -4 to 30
(4example) 

It's rather annoying when it goes to 0 and NFS traffic just stops
(especially annoying if one had cd burner and no BurnProof drive :>)

-- 
Janne
echo peufiuhu@tt.lac.nk | tr acefhiklnptu utpnlkihfeca

