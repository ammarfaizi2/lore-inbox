Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131067AbRAPWuA>; Tue, 16 Jan 2001 17:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131430AbRAPWtv>; Tue, 16 Jan 2001 17:49:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:46979 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131067AbRAPWtg>; Tue, 16 Jan 2001 17:49:36 -0500
Date: Tue, 16 Jan 2001 17:49:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Eli Carter <eli.carter@inet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: lance.c @ 100Mbit
In-Reply-To: <3A64CADF.17C9B9A3@inet.com>
Message-ID: <Pine.LNX.3.95.1010116174603.28076A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Eli Carter wrote:

> Quick question:  has anyone used the lance.c driver for a 100BaseT
> network PCI device?  If so, what successes/failures did you run into?
> 
> (I'm working with an Am79C973 chip.)
Sure. It's the pcnet32.c file (not lance from which it came). It works
fine in an embedded system and I'm currently adding some stuff to
write/rewrite the SEEPROM which contains the IEEE address plus some
stuff to init it upon reset.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
