Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277708AbRJIDW3>; Mon, 8 Oct 2001 23:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277706AbRJIDWU>; Mon, 8 Oct 2001 23:22:20 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:64418 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S277010AbRJIDWF>; Mon, 8 Oct 2001 23:22:05 -0400
Message-ID: <3BC26BDE.45D893A6@rcn.com.hk>
Date: Tue, 09 Oct 2001 11:15:42 +0800
From: David Chow <davidchow@rcn.com.hk>
Organization: Resources Computer Network Ltd.
X-Mailer: Mozilla 4.76 [zh_TW] (X11; U; Linux 2.4.4-1DC i686)
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: Alistair Riddell <ali@gwc.org.uk>
CC: raid@ddx.a2000.nu, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: write/read cache raid5
In-Reply-To: <Pine.LNX.4.21.0110082213240.29428-100000@frank.gwc.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Riddell ¼g¹D¡G
> 
> On Mon, 8 Oct 2001 raid@ddx.a2000.nu wrote:
> 
> > So there is no way i can Speedup write to the raid5 array ?
> > (memory will be ecc and the server will be on ups)
> 
> Your disks go as fast as they go, that is a physical limitation.
> 
> More RAM means your server can store up data blocks to be written when the
> disks are less busy. But the data still has to be written to disk
> sometime.
> 
> More RAM will certainly help by caching reads though.
> 
> 6 disks raided together means the bottleneck will likely be your network,
> unless your server is on gigabit ethernet and has a ton of clients and/or
> gigabit to the desktop.
> 
> --
> Alistair Riddell - BOFH
> IT Manager, George Watson's College, Edinburgh
> Tel: +44 131 447 7931 Ext 176       Fax: +44 131 452 8594
> Microsoft - because god hates us
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Yes my server serve lots of clients and have lots of NICs even
gigabit... how can I increase write/read cache on RAID5 ? It is better
performed when big cache allows on top (before) raid computation work
and physical disk writes.
