Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265126AbTLKPVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTLKPVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:21:50 -0500
Received: from legolas.restena.lu ([158.64.1.34]:29148 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S265126AbTLKPVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:21:20 -0500
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
From: Craig Bradney <cbradney@zip.com.au>
To: Jesse Allen <the3dfxdude@hotmail.com>
Cc: Ian Kumlien <pomac@vapor.com>, linux-kernel@vger.kernel.org,
       ross@datscreative.com.au, macro@ds2.pg.gda.pl
In-Reply-To: <20031211145847.GA609@tesore.local>
References: <200312072312.01013.ross@datscreative.com.au>
	 <200312101543.39597.ross@datscreative.com.au>
	 <Pine.LNX.4.55.0312101653490.31543@jurand.ds.pg.gda.pl>
	 <200312111655.25456.ross@datscreative.com.au>
	 <1071143274.2272.4.camel@big.pomac.com> <20031211145847.GA609@tesore.local>
Content-Type: text/plain
Message-Id: <1071156058.14260.55.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 16:20:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not really sure what I'm looking at here but as you guys are showing
this information I thought it might be helpful for those that can use it
to have the information run on a Asus A7N8X Deluxe (v2.0 bios 1007) with
Athlon XP 2600+. 

===============================================================================

MPTable, version 2.0.15 Linux

-------------------------------------------------------------------------------

MP Floating Pointer Structure:

  location:                     BIOS
  physical address:             0x000f5ce0
  signature:                    '_MP_'
  length:                       16 bytes
  version:                      1.1
  checksum:                     0x00
  mode:                         Virtual Wire

-------------------------------------------------------------------------------

MP Config Table Header:

  physical address:             0x0xf0c00
  signature:                    '
'
  base table length:            65287
  version:                      1.255
  checksum:                     0x04
  OEM ID:                       ''
  Product ID:                   ''
  OEM table pointer:            0x00000704
  OEM table size:               15
  entry count:                  3896
  local APIC address:           0x00070500
  extended table length:        3584
  extended table checksum:      0

-------------------------------------------------------------------------------

MP Config Base Table Entries:

--
Processors:     APIC ID Version State           Family  Model   Step   
Flags
                13       0x 0    AP, usable      3       0       0      
0xff070600
                 0       0xff    BSP, usable     0       12      4      
0x0001
--
MPTABLE HOSED! record type = 53



Craig


On Thu, 2003-12-11 at 15:58, Jesse Allen wrote:
> My mptable output looks pretty weird.  (Product ID "ny Key "?)
> It doesn't even compare to the other two.  I have a shuttle AN35N.
> 
> 
> ===============================================================================
> 
> MPTable, version 2.0.15 Linux
> 
> -------------------------------------------------------------------------------
> 
> MP Floating Pointer Structure:
> 
>   location:			BIOS
>   physical address:		0x000f5650
>   signature:			'_MP_'
>   length:			16 bytes
>   version:			1.1
>   checksum:			0x00
>   mode:				Virtual Wire
> 
> -------------------------------------------------------------------------------
> 
> MP Config Table Header:
> 
>   physical address:		0x0xf0c00
>   signature:			'N   '
>   base table length:		8224
>   version:			1.32
>   checksum:			0x20
>   OEM ID:			'    : '
>   Product ID:			'ny Key '
>   OEM table pointer:		0x2031462d
>   OEM table size:		17152
>   entry count:			29300
>   local APIC address:		0x32462d6c
>   extended table length:	32
>   extended table checksum:	67
> 
> -------------------------------------------------------------------------------
> 
> MP Config Base Table Entries:
> 
> --
> MPTABLE HOSED! record type = 114
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

