Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTE3Vxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 17:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTE3Vxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 17:53:31 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:58502 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S264124AbTE3Vx2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 17:53:28 -0400
From: Nicolas <linux@1g6.biz>
To: celestar@t-online.de (Frank Victor Fischer), linux-kernel@vger.kernel.org
Subject: Re: Hit BUG() in 2.5.70 in mm/slab.c:979
Date: Sat, 31 May 2003 00:08:17 +0200
User-Agent: KMail/1.5
References: <1054321005.2063.8.camel@darkstar.fischer.homeip.net>
In-Reply-To: <1054321005.2063.8.camel@darkstar.fischer.homeip.net>
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305310008.17299.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Maybe interesting for someone,

I have many slabs, and what we have in common is
e100 and I have an saa7134 (TV card too) all other is different
But I don't use my tv card at all.
I remember there is two differrents e100 drivers which one do you use ?
e100 one or eepro100 one ?, personally I use the e100 one.

Regards.

Nicolas.



Le Vendredi 30 Mai 2003 20:56, Frank Victor Fischer a écrit :
> Hey people,
> I hit a BUG() when testing a 2.5.70 kernel in mm/slab.c, line 979.
> I thought someone might want to know.
>
> System is:
>
> AMD Thunderbird 1000,
> VIA KT133 chipset
> 512 MB SDR SDRAM
>
> Other installed hardware:
> BT848 video capture device
> SB Live! Platinum EMU10k1
> Etherexpress Pro 100
> Promise UDMA 100 IDE controller, 20265 (no devices connected)
> GeForce 2 MX VGA card.
>
> hda: Maxtor 53073U6
> hdb: IBM-DCAA-33610
> hdc: HL-DT-ST SCE-8480B (CDRW)
> hdd: CREATIVEDVD6630E
>
> Used gcc: 2.95.3
> root file system: ext3
>
> floppy disk :)
>
> I am no member of the list, so for any more information, please contact
> me on celestar@t-online.de thanks
>
> Victor
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

