Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267469AbTAGSee>; Tue, 7 Jan 2003 13:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbTAGSee>; Tue, 7 Jan 2003 13:34:34 -0500
Received: from robur.slu.se ([130.238.98.12]:34828 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S267469AbTAGSed>;
	Tue, 7 Jan 2003 13:34:33 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15899.8623.323398.889764@robur.slu.se>
Date: Tue, 7 Jan 2003 19:51:27 +0100
To: Steffen Persvold <sp@scali.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NAPI and tg3
In-Reply-To: <Pine.LNX.4.44.0301070015320.16633-100000@sp-laptop.isdn.scali.no>
References: <1041875880.17472.47.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.4.44.0301070015320.16633-100000@sp-laptop.isdn.scali.no>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steffen Persvold writes:
 > 
 > I've also tried the NAPI patch for e1000 and it experience the same 
 > performance problem with multithreaded apps. The "NAPI-HOWTO" doesn't 
 > mention that this could be an issue at all. Does any of the NAPI authors 
 > (Jeff ?) have any comments ?

 Well wasn't ksoftirqd the general solution to schedule softirq's to run
 before next interrupt and by putting them under scheduler control the
 consecutive softirq's is prevented to monopolize the CPU.

 Well you're right the doc may mention this...

 Cheers.
						--ro
