Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270309AbRHTLKK>; Mon, 20 Aug 2001 07:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270267AbRHTLJu>; Mon, 20 Aug 2001 07:09:50 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:7695 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S270309AbRHTLJo>; Mon, 20 Aug 2001 07:09:44 -0400
Message-ID: <3B80EFB3.7F52B40D@idb.hist.no>
Date: Mon, 20 Aug 2001 13:08:35 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.3.95.1010819211427.28054B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
[...]
> If you want some kind of security, you need to at least
> hit the reset button before the feds carry it away.
> The normal initialization of SDRAM will wipe out whatever
> it has, and you can't get it back on-line without this
> sequence.

This initialization may be a requirement, that don't mean
it is going to happen.  Someone might crack your machine
and burn a new bios for you without RAM initialization.
Then they physically break in and take the box when
they believe there's something worth stealing in it.
(I.e. something interesting is on the disk, and the
decryption keys is in memory.)

Non-erasable bioses can of course be replaced too.
This can be done "live", as modern os'es don't use
the bios much after booting anyway.

Helge Hafting
