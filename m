Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274045AbRISNKd>; Wed, 19 Sep 2001 09:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274046AbRISNKX>; Wed, 19 Sep 2001 09:10:23 -0400
Received: from [195.66.192.167] ([195.66.192.167]:7177 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S274045AbRISNKL>; Wed, 19 Sep 2001 09:10:11 -0400
Date: Wed, 19 Sep 2001 16:08:05 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1022874923.20010919160805@port.imtp.ilyichevsk.odessa.ua>
To: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <Pine.GSO.4.21.0109190034030.7240-100000@skiathos.physics.auth.gr>
In-Reply-To: <Pine.GSO.4.21.0109190034030.7240-100000@skiathos.physics.auth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wednesday, September 19, 2001, 12:39:07 AM,
Liakakis Kostas <kostas@skiathos.physics.auth.gr> wrote:

LK> Please consider making it a configurable option. 

LK> My Asus A7V133 runs perfectly well with 55.7=1 and so does at least
LK> another mobo brand that was reported here. If it can work out of the box,
LK> leave it that way. Since this register is undocumented the patch below is
LK> a hack. Sure it works on people hitting the problem but it is still a
LK> hack. As such I don't want to use it if I don't have to.

Look into pci-pc.c amd quirks.c: do you want to make all those
config options too?

Also, do you want people to spend days finding out why their
once stable system with their brand new, faster processor
started to oops, finally giving up and posting about this to lkml?
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


