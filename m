Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132549AbQLIBXu>; Fri, 8 Dec 2000 20:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135323AbQLIBXn>; Fri, 8 Dec 2000 20:23:43 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:53980 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S132549AbQLIBXM>;
	Fri, 8 Dec 2000 20:23:12 -0500
Date: Fri, 8 Dec 2000 16:52:43 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re : [RFC-2] Configuring Synchronous Interfaces in Linux
Message-ID: <20001208165243.F26305@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote :
>                         struct wireless_physical 
>                         struct wireless_80211 
>                         struct wireless_auth 

	Please do not underestimate 802.11 (and others). Even two
cards based on the same MAC controller can have very different way to
handle bit rate setting (fixed, auto with fallback, range, ...). Check
wvlan_cs.c and airo.c for details...
	And also remember that 802.11 is not the only Wireless LAN out
there, there are more Symphony + HomeRF sold through retail than
802.11 combined. Not talking of HiperLAN 1/2...
	Regards,

	Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
