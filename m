Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFSTz>; Wed, 6 Dec 2000 13:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQLFSTo>; Wed, 6 Dec 2000 13:19:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:47746 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129183AbQLFST0>; Wed, 6 Dec 2000 13:19:26 -0500
Date: Wed, 6 Dec 2000 12:48:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Giacomo Catenazzi <cate@student.ethz.ch>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre4: spurious 8259A interrupt: IRQ7.
In-Reply-To: <3A2E6E2B.52406DE4@student.ethz.ch>
Message-ID: <Pine.LNX.3.95.1001206124503.28875A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Giacomo Catenazzi wrote:

> On my box, with heavy load I saw:
> spurious 8259A interrupt: IRQ7.
> Newer seen this message before.
> 
> Linux (2.4.0.11.4) or my old slow box ?
> 
> 
> 	giacomo
> 

This is really "normal" occasionally, and probably should not be logged.
This "catch all" interrupt has to be handled, to keep the controllers
happy, but should not be of any concern. FYI, you can also get a
false cascade interrupt on some boxen.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
