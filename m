Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289080AbSAUJCQ>; Mon, 21 Jan 2002 04:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289098AbSAUJCH>; Mon, 21 Jan 2002 04:02:07 -0500
Received: from rzcomm4.rz.tu-bs.de ([134.169.9.55]:9734 "EHLO
	rzcomm4.rz.tu-bs.de") by vger.kernel.org with ESMTP
	id <S289097AbSAUJCD>; Mon, 21 Jan 2002 04:02:03 -0500
Message-ID: <3C4BD854.3010104@aei.mpg.de>
Date: Mon, 21 Jan 2002 09:59:00 +0100
From: Carsten Aulbert <aulbert@aei.mpg.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: FYI: Kernel boot-stall on Asus A7V266-D (AMD MPX 762&768)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here a small "bug" report with kernel 2.4.18pre4 (also with 2.4.17):

Asus BIOS allows setting of MPS 1.4 and MP Table, if MP Table is 
disabled, the second processor is not recognized (but I suppose that's 
guessable), if both are enabled the kernel boot until it stops with the 
following lines:
[...]
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present map
...changing IO-APIC physical APIC ID to 2...ok
...TIMER: vector=0x31 pin1=2 pin2=0

that's basically all I can tell you (Board: Asus A7v266-D, Chipset: AMD 
MPX, Northbridge AMD 762, Southbridge AMD768; Processors: 2x MP1800+, 
memory: Infineon 2x512 PC2100 CL2). Sorry if this does not suffice.

Please CC to me, since I'm not subscribed.
Cheers

Carsten
-- 
office: Am Mühlenberg 5, 14476 Potsdam, +331-5677253, Fax: +33-5677298
	aulbert@aei-potsdam.mpg.de
priv. : Clara-Zetkin-Strasse 9, 14471 Potsdam, +331-9513352
	carsten@welcomes-you.com

