Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318059AbSHZKrY>; Mon, 26 Aug 2002 06:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318060AbSHZKrY>; Mon, 26 Aug 2002 06:47:24 -0400
Received: from pop.gmx.net ([213.165.64.20]:13377 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S318059AbSHZKrX>;
	Mon, 26 Aug 2002 06:47:23 -0400
Message-ID: <3D6A0862.10306@gmx.net>
Date: Mon, 26 Aug 2002 12:52:18 +0200
From: Mike <mbmarduk@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.19 Kernel Panic while copying from IDE cdrom
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I noticed this CD was a cheap'n'orrible no-name thing and put against a 
light source you could actually see some of the media being eaten away 
:/ but I just had to try...valuable data thero.
I mounted my IDE cdrom on /dev/hdc and copied the files (with midnight 
commander) to vfat partiton /dev/hda5. When the panic occured the 
keyboard scroll lock and caps lock lights kept on blinking.
Greetz,
Mike666

Message:
-------------------------------------------------------------------------

Unable to handle kernel paging request at virual address 63e5b005
*pde = 00000000[
Oops: 2
CPU: 0
eip: 0010:[<c01ca211>] Not tainted
EFLAGS: 00010002
eax: 63e5ae81 ebx: cfef1b40 ecx: 00000000 edx: cfef1b40
esi: c0302468 edi: 000000c0 ebp: cce68000 esp: c028fea8
  ds: 0018      es: 0018      ss: 0018

Process swapper (pid:0, stackpage = c028f000)
Stack:
cf1f1b40 c0302468 000000c0 00000296 c0302424 00000000 cf1f1b40 cff2dec0
c0302468 c01b4edc 00000000 c12ed280 c0302468 c12ed280 c01ca420 c0109b00
000000c0 c01b5b72 c0302468 c02547a2 000000c0 c12ed280 c01b5a10 00000000

Calltrace: c01b4edc c01ca420 c0109b00 c01b5b72 c01b5a10
c011e85f c011b2aa c011b1c6 c011afba c0109cad c0106c20
c0106c20 c010bf18 c0106c20 c0106c20 c0106c43 c0106cb2
c0105000 c0105027

Code: c7 80 84 01 00 00 00 00 07 00 83 7c 24 14 00 0f 84 9f 01 00

<0> Kernel Panic: Aiee, killing interrupt handler
In interrupt handler - not syncing

-------------------------------------------------------------------------

