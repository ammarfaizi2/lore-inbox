Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbREOWNI>; Tue, 15 May 2001 18:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbREOWM6>; Tue, 15 May 2001 18:12:58 -0400
Received: from warp9.koschikode.com ([212.84.196.82]:15627 "HELO
	warp9.koschikode.com") by vger.kernel.org with SMTP
	id <S261640AbREOWMl>; Tue, 15 May 2001 18:12:41 -0400
Message-ID: <3B01A9D2.2E36F44E@koschikode.com>
Date: Wed, 16 May 2001 00:12:34 +0200
From: Juri Haberland <juri@koschikode.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-SGI_XFS_1.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 3c900 card and kernel 2.4.3
In-Reply-To: <20010504203107.DVQ23593.amsmta01-svc@[192.168.2.1]> <20010514111251.32556.qmail@babel.spoiled.org> <3AFFD5B1.82678220@uow.edu.au> <3B01A67C.757934A2@koschikode.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juri Haberland wrote:
> 
> Andrew Morton wrote:
> 
> > For non-modular drivers things are less easy.  If you
> > want to force it to use 10baseT (if_port zero) then
> > it should work OK if you cheat and use mem_start=0x400.
> > So `ether=0,0,0x400'.
> >
> > For BNC, it should work just fine with `ether=0,0,1'.
> > If it doesn't, please shout at me.   Compile the
> > driver with `static int vortex_debug = 7;' at line
> > 183 and send me the boot logs.
> 
> Hi Andrew,
> 
> I tried it with 'ether=0,0,1', 3 and also 7, but to no avail. The output
> of dmesg follows.

Oh, and I forgot to say, that the card is actually set to autoselection
in the EEPROM (I just had a look with the DOS tool).

Juri
