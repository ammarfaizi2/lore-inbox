Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280084AbRKNEEp>; Tue, 13 Nov 2001 23:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280086AbRKNEEf>; Tue, 13 Nov 2001 23:04:35 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:10515 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S280084AbRKNEET>;
	Tue, 13 Nov 2001 23:04:19 -0500
Date: Wed, 14 Nov 2001 05:04:07 +0100
From: Werner Almesberger <wa@almesberger.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
Message-ID: <20011114050407.A17643@almesberger.net>
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com> <20011106095527.A10279@kroah.com> <3BE9BDD0.2070703@gutschke.com> <20011107151806.A22444@kroah.com> <3BEAD904.2050406@gutschke.com> <20011112111424.J25962@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011112111424.J25962@kroah.com>; from greg@kroah.com on Mon, Nov 12, 2001 at 11:14:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> I just had a report of someone getting this to work by using 
> "protocol: net"

Worked for me, thanks a lot ! The kernel complained about some
unrecognized packet on the first try/tries, but now it always seems to
work.

Linux 2.4.15-pre4 on Sony Vaio C1VN, ColdSync 2.2.3, Sony Clie N710C
upgraded to PalmOS 4.1.

"protocol: simple" yields:

  ##### Bad response ID: expected 0x9a, got 0x93.
  Warning: Restore: Can't delete database "BigClock": -1.
  Error: Can't restore directory.
  ##### Bad response ID: expected 0xaf, got 0x9a.
  Error: Error during DlpEndOfSync: (7) Invalid request ID.

Trying to use ttyUSB1 always yields:

  visor.c: Device lied about number of ports, please use a lower one.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Lausanne, CH                    wa@almesberger.net /
/_http://icawww.epfl.ch/almesberger/_____________________________________/
