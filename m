Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313131AbSDYNqH>; Thu, 25 Apr 2002 09:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313132AbSDYNqG>; Thu, 25 Apr 2002 09:46:06 -0400
Received: from proxyserver.epcnet.de ([62.132.156.25]:5642 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S313131AbSDYNqG>; Thu, 25 Apr 2002 09:46:06 -0400
Date: Thu, 25 Apr 2002 15:45:59 +0200
From: jd@epcnet.de
To: davem@redhat.com
Subject: AW: Re: AW: Re: AW: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156651750.avixxmail@nexxnet.epcnet.de>
In-Reply-To: <20020424.152137.50299257.davem@redhat.com>
X-Priority: 3
X-Mailer: avixxmail 1.2.2.7
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: text/plain; charset="iso-8859-1";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: <davem@redhat.com>
> Gesendet: 25.04.2002 00:33
>
>    Ok. I think NETIF_F_VLAN_CHALLENGED should be set if the device or
>    driver can handle VLAN.
> No, "challenged" means "cannot handle".  Do not invert the meaning,
> the macro says what the meaning is.

Why not call it NETIF_F_VLAN ?
 
> To get the behavior you want, we set the flat by default

What does this mean, "set the flat by default", setting NETIF_F_VLAN_CHALLENGED by default?

> and drivers
> for devices which are deemed "VLAN capable" can set the bit
> themselves.

If it works for older thirdparty (< 2.4.19) driver too (without any changes - only recompile), it would be great.

Greetings

     Jochen Dolze

