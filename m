Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288579AbSBRW16>; Mon, 18 Feb 2002 17:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288623AbSBRW1s>; Mon, 18 Feb 2002 17:27:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13833 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288579AbSBRW1p>; Mon, 18 Feb 2002 17:27:45 -0500
Subject: Re: Serial Console changes in linux 2.4.15??
To: penguin@wombat.ca (Craig)
Date: Mon, 18 Feb 2002 22:41:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.42.0202181657240.23209-100000@wombat> from "Craig" at Feb 18, 2002 05:16:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16cwTv-00073S-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If i manually put the lines back (the "#if 0" and "#endif"), then my serial
> console works just fine.

Except that you broke serial support for CREAD control

> Did someone submit serial.c with the "#if 0" lines removed by accident?

No

> My other question is: Why does this break the serial console?

Your user space is buggy I think, and didn't set CREAD
