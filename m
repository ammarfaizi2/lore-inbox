Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTJDFOO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 01:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTJDFOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 01:14:14 -0400
Received: from 200-184-148-66.dba.com.br ([200.184.148.66]:9785 "EHLO
	SCUTUM.dba.com.br") by vger.kernel.org with ESMTP id S261825AbTJDFOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 01:14:10 -0400
Message-ID: <A36146B96FA84B4BB69EB088451E965A080CE792@cygnus>
From: Juan Carlos Castro Y Castro <jcastro@dba.com.br>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Kernel doesn't see USB ADSL modem - pegasus?
Date: Sat, 4 Oct 2003 02:10:57 -0300 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="=_Boundary_PUPeKljq65Rn8P5o7P6u"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--=_Boundary_PUPeKljq65Rn8P5o7P6u
Content-Type: text/plain

(Please CC me here and at jcastro@vialink.com.br -- I'm not subscribed)

I have a SpeedStream 5200 ADSL modem, connected to the USB port. From what I
understand, the pegasus driver should see it. I installed 2.4.23-pre6,
modprobe'd usbnet and pegasus, but no new interface shows up. (I tested with
ip link show)

Maybe I should patch the driver to include a device ID or something of the
sort?

This is the contents of /proc/bus/usb/devices:

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d800
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=ff Prot=ff MxPS= 8 #Cfgs=  1
P:  Vendor=067c ProdID=e240 Rev= 1.01
S:  Manufacturer=Efficient Networks, Inc.
S:  Product=SpeedStream
S:  SerialNumber=SpeedStream
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=ff Driver=(none)
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
--=_Boundary_PUPeKljq65Rn8P5o7P6u
Content-Type: text/plain;
	charset=UTF-8
Content-Transfer-Encoding: quoted-printable

**********************************************************************
 Informa=C3=A7=C3=A3o transmitida destina-se apenas =C3=A0 pessoa a quem=
 foi endere=C3=A7ada e pode conter informa=C3=A7=C3=A3o confidencial,=
 legalmente protegida e para conhecimento exclusivo do destinat=C3=A1rio.=
 Se o leitor desta advert=C3=AAncia n=C3=A3o for o seu destinat=C3=A1rio,=
 fica ciente de que sua leitura, divulga=C3=A7=C3=A3o ou c=C3=B3pia =C3=A9=
 estritamente proibida. Caso a mensagem tenha sido recebida por engano,=
 favor comunicar ao remetente e apagar o texto de qualquer computador.


The information transmitted is intended only for the person or entity to=
 which it is addressed and may contain confidential and/or privileged=
 material. Any review, retransmission, dissemination or other use of, or=
 taking of any action in reliance upon this information, by person or=
 entity other than the intended recipient is prohibited. If you received=
 this in error, please contact the sender and delete the material from any=
 computer.
**********************************************************************
--=_Boundary_PUPeKljq65Rn8P5o7P6u--
