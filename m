Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSKRKBF>; Mon, 18 Nov 2002 05:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSKRKBF>; Mon, 18 Nov 2002 05:01:05 -0500
Received: from mailproxy.de.uu.net ([192.76.144.34]:964 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S261900AbSKRKBE> convert rfc822-to-8bit; Mon, 18 Nov 2002 05:01:04 -0500
Message-ID: <7A5D4FEED80CD61192F2001083FC1CF906505A@CHARLY>
From: "Filipau, Ihar" <ifilipau@sussdd.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: useless image of hdd: how to make it useful?
Date: Mon, 18 Nov 2002 11:08:10 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All!

	[ please CC me - I'm not subscribed to the list. ]

	This question was in my mind for couple of years.
	But after all I decided to ask it. (Better later - than never ;-))

	Little prehistory: I had on my old home PC two hard drives - hda &
hdc.
		hda was big and new, while hdc was old, small and sure it
contained 
		a lot of old useful stuff. So I decided to upgrade my very
valuable hdc.
		And sure, as simple novice in hdd upgrades, I've made smth
like:
			# dd if=/dev/hdc of=/root/hdc_img
		And right after upgrade - I got small rebate in exchange for
my old hdd - 
		I understood my problem.

	I do not know the way to mount partition table!
	it's possible with loop device to mount partition - but how to mount
whole 
	hdd (with its own partition table) to have access to single
partition inside???

	Digging into the kernel (it was 2.2 times) brought no answer:
major+minor was 
	used to identify the partition and I saw no way I can give this
beast 
	a file - not real hard drive.

	So that's the question:

	Is it possible to mount a 'hard drive' - just like any other fs -
and see 
	inside of this fs partitions as regular files?

PS As for my hdc - very quickly I came back to the shop and reversed my
/upgrade/... ;-)))

--- Regards&Wishes! With respect  Ihar "Philips" Filipau AKA Igor Philippov,
and Phil for friends

- - - - - - - - - - - - - - - - - - - - - - - - -
MCS/Mathematician - System Programmer
Ihar Filipau 
Software entwickler @ SUSS MicroTec Test Systems GmbH, 
Süss-Strasse 1, D-01561 Sacka (bei Dresden)
e-mail: ifilipau@sussdd.de  tel: +49-(0)-352-4073-327
fax: +49-(0)-352-4073-700   web: http://www.suss.com/
