Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269378AbRHGTe3>; Tue, 7 Aug 2001 15:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269365AbRHGTeT>; Tue, 7 Aug 2001 15:34:19 -0400
Received: from rom.cscaper.com ([216.19.195.129]:28653 "HELO mail.cscaper.com")
	by vger.kernel.org with SMTP id <S269364AbRHGTeK>;
	Tue, 7 Aug 2001 15:34:10 -0400
Subject: Linux on FIVA MPC-206E, APM and other issues
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
From: "Joseph N. Hall" <joseph@5sigma.com>
Ccc: 
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Tue, 7 Aug 2001 12:34 -0700
X-mailer: Mailer from Hell v1.0
Message-Id: <20010807193417Z269364-28344+2551@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Not on list, please CC)

I am a happy new owner of a Casio FIVA MPC-206E (teensy 2.1 lb subnotebook)
with RH 7.1 and 2.4.7 installed.  I'm trying to get a variety of things
working, some of which may or may not be related to needed kernel tweaks.
I suspect some of these have been address already by Japanese users, but
alas I cannot read Japanese.

* APM broken

  $ cat /proc/apm
  1.14 1.2 0x03 0x01 0xff 0x80 -1% -1 ?

* 24 bit X support broken (an XFree86 issue, I suppose, will check there
shortly); there is something funny about 24 bit mode on this machine
anyway even in WIndowsMe mode

* sleep/hibernate either hangs the machine (must hit h/w reset switch
afaik) or does nothing useful (nothing at all, or seemingly tries to 
sleep and immediately revives)

* (soft) power switch and cover latch not detected

* no access to "P1 P2 P3" buttons that live to the right side of the LCD
screen

* Also I've been having no luck getting a DWL-650 (D-Link 802.11 card)
recognized and working ... was close with the wvlan_cs(? one of those)
driver but I'm operating on the assumption that the orinoco_cs driver is 
more current, and can't get it recognized at all

I'm not expecting to get everything going right away but I'd appreciate
any pointers etc.  I have relatively little experience mucking about in
the kernel but I'll be happy to try patches etc. and post my results.

  -joseph

