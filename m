Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274587AbRIYKF1>; Tue, 25 Sep 2001 06:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274589AbRIYKFI>; Tue, 25 Sep 2001 06:05:08 -0400
Received: from smtp3.libero.it ([193.70.192.53]:25302 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S274587AbRIYKE5>;
	Tue, 25 Sep 2001 06:04:57 -0400
Subject: Re: Burning a CD image slow down my connection
From: "[A]ndy80" <andy80@ptlug.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E15loh3-0005PD-00@the-village.bc.nu>
In-Reply-To: <E15loh3-0005PD-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.24.08.08 (Preview Release)
Date: 25 Sep 2001 12:13:16 +0200
Message-Id: <1001412802.1316.4.camel@piccoli>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Make sure you have DMA enabled for your IDE cd-rom or ide unmasking
enabled
> for it (see man hdparm)

these are my settings for my 2 HD:

hdparm -c 1 -d 1 -k 1 /dev/hda
hdparm -c 1 -d 1 -k 1 /dev/hdb

I've my Plextor Writer as secondary master seen as a scsi device and if
I try do use hdparm it says:

[root@piccoli shady]# hdparm -t /dev/cdrom
/dev/cdrom not supported by hdparm

What else ahve I to enable?


--
[A]ndy80 - andy80@ptlug.org


