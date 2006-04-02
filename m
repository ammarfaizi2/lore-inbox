Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWDBWbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWDBWbl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWDBWbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:31:41 -0400
Received: from web30613.mail.mud.yahoo.com ([68.142.201.246]:60496 "HELO
	web30613.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932431AbWDBWbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:31:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QzNZ7ncOAqpsvMYzSLn0IRK+s6U9bVOvLc85TTlNIbUwBOVauOVq19HSbVfPZ9aXl2s66bbj0t6efxasCmNNHYZi6nMlwpotMVlP/CHQa9AsMooPEEmpuGGxl8rZd5ipwgfdgAi4j2VxUQshzNnFEiGke7k1IYkE15zOATBfie8=  ;
Message-ID: <20060402223137.30538.qmail@web30613.mail.mud.yahoo.com>
Date: Mon, 3 Apr 2006 00:31:37 +0200 (CEST)
From: zine el abidine Hamid <zine46@yahoo.fr>
Subject: Re: Detecting I/O error and Halting System
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143560163.17522.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dick,

Excuses me for the silence.

Can you tell me why the drive stops to respond? Where
the problem starts? As I tell before, we tried
different drives and that has not help us.

Friday, The constructor comes to a meeting in our
offices and they affirm that their materials is ok.

Have you read some articles that pointed out failures
on the South Bridge VIA VT82c686 or other's chipset
off the VIA PN133 architecture?
(http://www.via.com.tw/en/products/chipsets/legacy/pn133/)

If it can help, this are the description :


00:00.0 Host bridge: VIA Technologies, Inc. VT8605
[ProSavage PM133] (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8605
[PM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686
[Apollo Super South] (rev 40
)
00:07.1 IDE interface: VIA Technologies, Inc. Bus
Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB
(rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. USB
(rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686
[Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies,
Inc. VT82C686 AC97 Audio
Controller (rev 50)
00:10.0 Ethernet controller: Intel Corp. 82557/8/9
[Ethernet Pro 100] (rev 08)
01:00.0 VGA compatible controller: S3 Inc. ProSavage
PM133 (rev 02)
[root@Porte_de_Clignancourt_nds_b root]# lspci -n
00:00.0 Class 0600: 1106:0605 (rev 01)
00:01.0 Class 0604: 1106:8605
00:07.0 Class 0601: 1106:0686 (rev 40)
00:07.1 Class 0101: 1106:0571 (rev 06)
00:07.2 Class 0c03: 1106:3038 (rev 1a)
00:07.3 Class 0c03: 1106:3038 (rev 1a)
00:07.4 Class 0680: 1106:3057 (rev 40)
00:07.5 Class 0401: 1106:3058 (rev 50)
00:10.0 Class 0200: 8086:1229 (rev 08)
01:00.0 Class 0300: 5333:8a25 (rev 02)



processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 998.393
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29



--- Alan Cox <alan@lxorguk.ukuu.org.uk> a écrit :

> On Maw, 2006-03-28 at 17:07 +0200, zine el abidine
> Hamid wrote:
> > I don't think that it's a HDD problem nor a cable
> > problem because the servers are new. We have tried
> 
> New. Thats another word for "untested" I believe 8)
> 
> > How can I determine the problem?
> 
> I would consult the hardware vendor
> 
> > I want to add that the HDD seems to be
> disconnected
> > (the BIOS can't find any drive for boot) after a
> > simple reset. We must switch off the servers to
> get
> > them work again.
> 
> Thats strongly indicating a hardware problem.
> 
> > (http://www.tldp.org/LDP/lkmpg/) but how can I
> > shutdown Linux from inside a module...? 
> 
> See the softdog driver for an example.
> 
> 



	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
