Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312704AbSDXW2L>; Wed, 24 Apr 2002 18:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312716AbSDXW2K>; Wed, 24 Apr 2002 18:28:10 -0400
Received: from mailextern.t-b-r.de ([62.132.156.25]:33802 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S312704AbSDXW2K>; Wed, 24 Apr 2002 18:28:10 -0400
Date: Thu, 25 Apr 2002 00:28:05 +0200
From: jd@epcnet.de
To: davem@redhat.com
Subject: AW: Re: AW: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <781920085.avixxmail@nexxnet.epcnet.de>
In-Reply-To: <20020424.104037.109544858.davem@redhat.com>
X-Priority: 3
X-Mailer: avixxmail 1.2.2.7
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: text/plain; charset="iso-8859-1";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: <davem@redhat.com>
> Gesendet: 24.04.2002 19:50
>
>    Mhh, did not found the symbol in netdevice.h on stock 2.4.18.    
> See 2.4.19-preX

Ok. I think NETIF_F_VLAN_CHALLENGED should be set if the device or driver can handle VLAN.
So older third party drivers (based on < 2.4.19) get denied at first, till the driver maintainer explicitly set the NETIF_F_VLAN_CHALLENDGED capability (or one of the VLAN-hardware capabilities).

Greetings

     Jochen Dolze

