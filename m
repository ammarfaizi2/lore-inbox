Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270568AbRHNLij>; Tue, 14 Aug 2001 07:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270569AbRHNLi3>; Tue, 14 Aug 2001 07:38:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56335 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270568AbRHNLiT>; Tue, 14 Aug 2001 07:38:19 -0400
Subject: Re: Camino 2 (82815/82820) v2.4.x eth/sound related lockups
To: ime@iaehv.iae.nl (Ime Smits)
Date: Tue, 14 Aug 2001 12:40:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSF.4.05.10108141301230.92637-100000@iaehv.iae.nl> from "Ime Smits" at Aug 14, 2001 01:31:07 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WcZ9-0000zr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Funny things in syslog include:
> kernel: mtrr: base(0xe8000000) is not aligned on a
> size(0x4b0000) boundary

Thats
ok

> kernel: eepro100: wait_for_cmd_done timeout!

Those are not so good. I was having similar problems on an i810 box with
onboard eepro100 until I disabled the pm stuff in 2.4.8ac2, but you
seem to be running that one

Alan
