Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030771AbWKUOBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030771AbWKUOBA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 09:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030971AbWKUOBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 09:01:00 -0500
Received: from c2bthomr02.btconnect.com ([194.73.73.210]:41312 "EHLO
	c2bthomr02.btconnect.com") by vger.kernel.org with ESMTP
	id S1030771AbWKUOA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 09:00:59 -0500
In-Reply-To: <20061121132807.GB23235@isilmar.linta.de>
References: <200611201306.kAKD6gRt008347@imap.elan.private> <20061120174924.GC18660@isilmar.linta.de> <1164099203.30853.51.camel@n04-143.elan.private> <20061121132807.GB23235@isilmar.linta.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-14--1020765540
Message-Id: <1C45F4D7-A8EA-4902-BFC5-5B6AA0181D96@elandigitalsystems.com>
Cc: Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
From: Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH] PCMCIA identification strings for Elan -- second attempt
Date: Tue, 21 Nov 2006 13:58:31 +0000
To: Dominik Brodowski <linux@dominikbrodowski.net>
X-Mailer: Apple Mail (2.752.2)
Elan-checked-message-originator: tony.olech@elandigitalsystems.com == tony-olech
Elan-message-recipient: linux@dominikbrodowski.net
Elan-message-recipient: linux-pcmcia@lists.infradead.org
Elan-message-recipient: perex@suse.cz
Elan-message-recipient: dahinds@users.sourceforge.net
Elan-message-recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-14--1020765540
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hi,
I can't find an actual device, and my former boss
left Elan a few months ago, but I have attached
the data from our product database:

cis configuration file: 
--Apple-Mail-14--1020765540
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	x-unix-mode=0640;
	name=SL432.TXT
Content-Disposition: attachment;
	filename=SL432.TXT

;=
**************************************************************************=
**************=0D
;*=0D
;* Filename:        sl432.txt=0D
;*=0D
;* Author:          P. Sleeman        Elan Digital Systems Limited  (c) =
2003=0D
;*=0D
;* Date:            19/05/2003=0D
;*=0D
;* Description:     This file defines the CIS for the SL432 PC Card=0D
;*=0D
;* File Revision:   1.01=0D
;*=0D
;* History:         Rev.     Date           Revision History=0D
;*                  1.00     19/05/2003     Creation=0D
;*=0D
=
;*************************************************************************=
*************** =0D
=0D
$01 $03 $00 $00 $FF=0D
$15 $3A $05 $00 [Elan] $00 [Serial Port: SL432] $00 [1.00] $00 =
[KIT:Kxxxxx-xxx           ] $00 $FF =0D
$20 $04 $5D $01 [EL]=0D
$06 $15 $04 $00 $60 $00 $00 $00 $00 $B0 $00 $00 $00 $00 $00 $01 $00 $00 =
$00 $60 $01 $00 $00 ;long link MFC, 4 functions=0D
=0D
%60 ;pad to here with 0xffs.  Start of function 1's CIS=0D
=0D
$13 $03 [CIS] ;link target tuple=0D
$21 $02 $02 $01   ;identify as a serial port=0D
$1A $05 $01 $27 $00 $04 $61 ;2 byte config base,1 byte ccr presence =
mask, last table index is 27h, 400h base, cor, csr, iobase0&1 present=0D
=0D
;$1B $0D $C7 $01 $19 $01 $55 $AB $60 $F8 $03 $07 $B0 $FF $FF     ;com1 =
default settings: 5V, 3f8, IRQ share lvl & an IRQ mask =3D irq any=0D
;$1B $0B $8F $01 $18         $AB $60 $F8 $02 $07 $B0 $FF $FF     ;com2 =
2f8 irq any=0D
;$1B $0B $97 $01 $18         $AB $60 $E8 $03 $07 $B0 $FF $FF     ;com3 =
3E8 irq any=0D
;$1B $0B $9F $01 $18         $AB $60 $E8 $02 $07 $B0 $FF $FF     ;com4 =
2E8 irq any=0D
$1B $07 $A7 $01 $18         $23                 $B0 $FF $FF     ;comN =
any io on 8 byte boundary, lvl irq any in mask ffff=0D
$FF ;end of this function's CIS=0D
=0D
=0D
%B0 ;pad to here with 0xffs.  Start of function 2's CIS=0D
=0D
$13 $03 [CIS] ;link target tuple=0D
$21 $02 $02 $01   ;identify as a serial port=0D
$1A $05 $01 $27 $20 $04 $61 ;2 byte config base,1 byte ccr presence =
mask, last table index is 27h, 420h base, cor, csr, iobase0&1 present=0D
=0D
;$1B $0D $CF $01 $19 $01 $55 $AB $60 $F8 $02 $07 $B0 $FF $FF     ;com2 =
default settings: 5V, 2f8, IRQ share lvl & an IRQ mask =3D irq any=0D
;$1B $0B $87 $01 $18         $AB $60 $F8 $03 $07 $B0 $FF $FF     ;com1 =
3f8 irq any=0D
;$1B $0B $9F $01 $18         $AB $60 $E8 $02 $07 $B0 $FF $FF     ;com4 =
2e8 irq any=0D
;$1B $0B $97 $01 $18         $AB $60 $E8 $03 $07 $B0 $FF $FF     ;com3 =
3e8 irq any=0D
$1B $07 $A7 $01 $18         $23                 $B0 $FF $FF     ;comN =
any io on 8 byte boundary, lvl irq any in mask ffff=0D
$FF ;end of this function's CIS=0D
=0D
%100 ;pad to here with 0xffs.  Start of function 3's CIS=0D
=0D
$13 $03 [CIS] ;link target tuple=0D
$21 $02 $02 $01   ;identify as a serial port=0D
$1A $05 $01 $27 $40 $04 $61 ;2 byte config base,1 byte ccr presence =
mask, last table index is 27h, 400h base, cor, csr, iobase0&1 present=0D
=0D
;$1B $0D $D7 $01 $19 $01 $55 $AB $60 $E8 $03 $07 $B0 $FF $FF     ;com3 =
3E8 irq any=0D
;$1B $0B $9F $01 $18         $AB $60 $E8 $02 $07 $B0 $FF $FF     ;com4 =
2E8 irq any=0D
;$1B $0B $87 $01 $18         $AB $60 $F8 $03 $07 $B0 $FF $FF     ;com1 =
default settings: 5V, 3f8, IRQ share lvl & an IRQ mask =3D irq any=0D
;$1B $0B $8F $01 $18         $AB $60 $F8 $02 $07 $B0 $FF $FF     ;com2 =
2f8 irq any=0D
$1B $07 $A7 $01 $18         $23                 $B0 $FF $FF     ;comN =
any io on 8 byte boundary, lvl irq any in mask ffff=0D
$FF ;end of this function's CIS=0D
=0D
%160 ;pad to here with 0xffs.  Start of function 4's CIS=0D
=0D
$13 $03 [CIS] ;link target tuple=0D
$21 $02 $02 $01   ;identify as a serial port=0D
$1A $05 $01 $27 $60 $04 $61 ;2 byte config base,1 byte ccr presence =
mask, last table index is 27h, 400h base, cor, csr, iobase0&1 present=0D
=0D
;$1B $0D $DF $01 $19 $01 $55 $AB $60 $E8 $02 $07 $B0 $FF $FF     ;com4 =
2E8 irq any=0D
;$1B $0B $97 $01 $18         $AB $60 $E8 $03 $07 $B0 $FF $FF     ;com3 =
3E8 irq any=0D
;$1B $0B $87 $01 $18         $AB $60 $F8 $03 $07 $B0 $FF $FF     ;com1 =
default settings: 5V, 3f8, IRQ share lvl & an IRQ mask =3D irq any=0D
;$1B $0B $8F $01 $18         $AB $60 $F8 $02 $07 $B0 $FF $FF     ;com2 =
2f8 irq any=0D
$1B $07 $A7 $01 $18         $23                 $B0 $FF $FF     ;comN =
any io on 8 byte boundary, lvl irq any in mask ffff=0D
$FF ;end of this function's CIS=0D
=0D
$FF $FF=0D
=0D
$80 $11 [<DATE>dd.mm.yyyy] $00 =0D
$81 $2E [Copyright (c) Elan Digital Systems Ltd, 2003.] $00 =0D
=0D
=0D
%200  ;make the file 512 bytes long=0D
=1A=

--Apple-Mail-14--1020765540
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

the binary cis: 
--Apple-Mail-14--1020765540
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	x-unix-mode=0640;
	name=SL432.CIS
Content-Disposition: attachment;
	filename=SL432.CIS

AQMAAP8VOgUARWxhbgBTZXJpYWwgUG9ydDogU0w0MzIAMS4wMABLSVQ6S3h4eHh4LXh4eCAgICAg
ICAgICAgAP8gBF0BRUwGFQQAYAAAAACwAAAAAAABAAAAYAEAAP//EwNDSVMhAgIBGgUBJwAEYRsH
pwEYI7D/////////////////////////////////////////////////////////////////////
//////8TA0NJUyECAgEaBQEnIARhGwenARgjsP//////////////////////////////////////
/////////////////////////////////////xMDQ0lTIQICARoFASdABGEbB6cBGCOw////////
////////////////////////////////////////////////////////////////////////////
/////////////xMDQ0lTIQICARoFASdgBGEbB6cBGCOw//////+AETxEQVRFPmRkLm1tLnl5eXkA
gS5Db3B5cmlnaHQgKGMpIEVsYW4gRGlnaXRhbCBTeXN0ZW1zIEx0ZCwgMjAwMy4A////////////
//////////////////////////////////////////////////////////////////////////8=

--Apple-Mail-14--1020765540
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

the dump_cis_output: 
--Apple-Mail-14--1020765540
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=SL432.DUMP_CIS
Content-Disposition: attachment;
	filename=SL432.DUMP_CIS

offset 0x02, tuple 0x01, link 0x03
  00 00 ff 
dev_info
  NULL 0ns, 512b

offset 0x07, tuple 0x15, link 0x3a
  05 00 45 6c 61 6e 00 53 65 72 69 61 6c 20 50 6f 
  72 74 3a 20 53 4c 34 33 32 00 31 2e 30 30 00 4b 
  49 54 3a 4b 78 78 78 78 78 2d 78 78 78 20 20 20 
  20 20 20 20 20 20 20 20 00 ff 
vers_1 5.0, "Elan", "Serial Port: SL432", "1.00",
  "KIT:Kxxxxx-xxx           "

offset 0x43, tuple 0x20, link 0x04
  5d 01 45 4c 
manfid 0x015d, 0x4c45

offset 0x49, tuple 0x06, link 0x15
  04 00 60 00 00 00 00 b0 00 00 00 00 00 01 00 00 
  00 60 01 00 00 
mfc_long_link
 function 0: attr 0x0060
 function 1: attr 0x00b0
 function 2: attr 0x0100
 function 3: attr 0x0160

offset 0x60, tuple 0xff, link 0xff
  13 03 43 49 53 21 02 02 01 1a 05 01 27 00 04 61 
  1b 07 a7 01 18 23 b0 ff ff ff ff ff ff ff ff ff 
  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  13 03 43 49 53 21 02 02 01 1a 05 01 27 20 04 61 
  1b 07 a7 01 18 23 b0 ff ff ff ff ff ff ff ff ff 
  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  13 03 43 49 53 21 02 02 01 1a 05 01 27 40 04 61 
  1b 07 a7 01 18 23 b0 ff ff ff ff ff ff ff ff ff 
  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 


--Apple-Mail-14--1020765540
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


Tony Olech
Elan Digital Systems Limited
------------------------------------------------------------------------
On 21 Nov 2006, at 13:28, Dominik Brodowski wrote:

> On Tue, Nov 21, 2006 at 08:53:22AM +0000, Tony Olech wrote:
>> YES is does indeed have 4 serial channels.
>
> Four serial channels might be handled by two device functions...  
> and it's
> the number of device function which decides whether it is a "MFC"  
> device or
> not. And if it indeed has four sub-devices, the PCMCIA core needs  
> to be
> improved -- therefore, could you send me a CIS dump for this  
> device, please?
>
> Thanks,
> 	Dominik
>


--Apple-Mail-14--1020765540--
