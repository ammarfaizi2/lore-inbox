Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129874AbQK0J2Z>; Mon, 27 Nov 2000 04:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130237AbQK0J2P>; Mon, 27 Nov 2000 04:28:15 -0500
Received: from unimur.um.es ([155.54.1.1]:57068 "EHLO unimur.um.es")
        by vger.kernel.org with ESMTP id <S129874AbQK0J2K>;
        Mon, 27 Nov 2000 04:28:10 -0500
Message-ID: <3A221754.152C4574@ditec.um.es>
Date: Mon, 27 Nov 2000 09:12:04 +0100
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.75 [es] (X11; U; Linux 2.2.18pre22 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: eth0: trigger_send() called with the transmitter busy.
Content-Type: multipart/mixed;
 boundary="------------0C56E021DC6B3D5B28BA83B4"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Este es un mensaje multipartes en formato MIME.
--------------0C56E021DC6B3D5B28BA83B4
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi!

This error ocurrs when "named" is executed. It exists since
2.4.0-test10preX or so.

I'm using RedHat 7.0 and my ethernet card is a "Kingston EtheRx KNE20
Plug and Play ISA Adapter". I'm unable to access the Internet because
the ethernet card doesn't work :-(. Besides, the card uses two
interrupts (?) and there are two interfaces (eth0 y eth1) when I have
only one (?).

Bye!
-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
--------------0C56E021DC6B3D5B28BA83B4
Content-Type: text/plain; charset=us-ascii;
 name="interrupts.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts.txt"

           CPU0       
  0:      11683          XT-PIC  timer
  1:        258          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          1          XT-PIC  NE2000
 10:          0          XT-PIC  es1371
 12:          0          XT-PIC  NE2000
 14:       3047          XT-PIC  ide0
 15:          6          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0

--------------0C56E021DC6B3D5B28BA83B4
Content-Type: text/plain; charset=us-ascii;
 name="ioports.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioports.txt"

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0240-025f : eth1
02f8-02ff : serial(auto)
0300-031f : eth0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e800-e83f : Ensoniq ES1371 [AudioPCI-97]
  e800-e83f : es1371

--------------0C56E021DC6B3D5B28BA83B4
Content-Type: text/plain; charset=us-ascii;
 name="isapnp.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isapnp.txt"

Card 1 'KTC2000:Kingston EtheRx KNE20 Plug and Play ISA Adapter' PnP version 1.0 Product version 1.0
  Logical device 0 'RTL8019:Unknown'
    Supported registers 0x2
    Compatible device PNP80d6
    Device is active
    Active port 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
    Active IRQ 255 [0xff],255 [0xff]
    Active DMA 255,255
    Active memory 0xffffffff,0xffffffff,0xffffffff,0xffffffff
    Resources 0
      Priority preferred
      Port 0x240-0x380, align 0x1f, size 0x20, 10-bit address decoding
      IRQ 3,4,5,2/9,10,11,12,15 High-Edge

--------------0C56E021DC6B3D5B28BA83B4--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
