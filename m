Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRAEPxp>; Fri, 5 Jan 2001 10:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130682AbRAEPxf>; Fri, 5 Jan 2001 10:53:35 -0500
Received: from ANancy-101-1-1-133.abo.wanadoo.fr ([193.251.70.133]:21496 "HELO
	the-babel-tower.nobis.phear.org") by vger.kernel.org with SMTP
	id <S129868AbRAEPxY>; Fri, 5 Jan 2001 10:53:24 -0500
Date: Fri, 5 Jan 2001 16:58:52 +0100 (CET)
From: Nicolas Noble <Pixel@the-babel-tower.nobis.phear.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Nicolas Parpandet <nparpand@perinfo.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel network problem ?
In-Reply-To: <20010105174205.Q12545@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.21.0101051657210.10276-100000@the-babel-tower.nobis.phear.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Turn off the TCP_ECN option from your configuration,
> 	or do:
> 		echo 0 > /proc/sys/net/ipv4/tcp_ecn 
> 	(as root)
> 
> 	For foreseeable future, the world will be full of firewalls
> 	doing wrong thing when they see TCP ECN bits in TCP header's
> 	formerly "reserved, set to zero" bits.
> 

Yup, it worked fine. Thanks a lot.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
