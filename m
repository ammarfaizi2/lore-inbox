Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312364AbSDXRDX>; Wed, 24 Apr 2002 13:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSDXRDX>; Wed, 24 Apr 2002 13:03:23 -0400
Received: from viruswall.epcnet.de ([62.132.156.25]:11789 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S312364AbSDXRDW>; Wed, 24 Apr 2002 13:03:22 -0400
Date: Wed, 24 Apr 2002 19:03:19 +0200
From: jd@epcnet.de
To: davem@redhat.com
Subject: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <721506265.avixxmail@nexxnet.epcnet.de>
In-Reply-To: <20020424.093515.82125943.davem@redhat.com>
X-Priority: 3
X-Mailer: avixxmail 1.2.2.7
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: text/plain; charset="iso-8859-1";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: <davem@redhat.com>
> Gesendet: 24.04.2002 18:45
>
> There actually is a flag the driver can set fo this purpose.

Oh. Even in 2.4 ?
 
> Someone should walk over all the drivers that are known to not
> work currently with VLAN and for them to set the
> NETIF_F_VLAN_CHALLENGED flag.

That's a good idea. So vconfig could check, if its possible to create a VLAN on top of such a driver - and issue a message if not.

> Another idea, is to do the opposite, set that flag by default and
> clear it in drivers that we know it works.

It depends - if all drivers must be changed or just those, who support VLAN. I tend to a solution where just the VLAN-capable drivers should be changed.

