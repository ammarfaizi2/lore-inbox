Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281726AbRKULaB>; Wed, 21 Nov 2001 06:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281734AbRKUL3m>; Wed, 21 Nov 2001 06:29:42 -0500
Received: from tangens.hometree.net ([212.34.181.34]:55981 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S281724AbRKUL3i>; Wed, 21 Nov 2001 06:29:38 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: A return to PCI ordering problems...
Date: Wed, 21 Nov 2001 11:29:37 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9tg371$ja3$1@forge.intermeta.de>
In-Reply-To: <20011120190316.H19738@vnl.com> <2048.1006291657@redhat.com> <E166TCM-0004VH-00@lilac.csi.cam.ac.uk>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1006342177 31090 212.34.181.4 (21 Nov 2001 11:29:37 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 21 Nov 2001 11:29:37 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James A Sutherland <jas88@cam.ac.uk> writes:

>On Tuesday 20 November 2001 9:27 pm, David Woodhouse wrote:
>> amon@vnl.com said:
>> > In any case, here is the problem:
>> > 	NIC on motherboard, Realtek
>> > 	NIC on PCI card, Realtek
>> > 	Monolithic (no-module) kernel
>> > 	Motherboard must be set to eth0
>>
>> Why must the motherboard be set to eth0? Why not just configure it as it
>> gets detected?

>He has some software licensing thing which checks the MAC address of eth0.

>Of course, what he could do is change the MAC address of eth0 to whatever the 
>licensing software wants... :-)

One could imagine a module to read the MAC address from the eeprom and
not from the Interface.. Makes this scenario not impossible but much
harder.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
