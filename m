Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbRGMJJt>; Fri, 13 Jul 2001 05:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbRGMJJk>; Fri, 13 Jul 2001 05:09:40 -0400
Received: from sunu422.rz.ruhr-uni-bochum.de ([134.147.64.14]:18675 "HELO
	sunu422.rz.ruhr-uni-bochum.de") by vger.kernel.org with SMTP
	id <S266986AbRGMJJV>; Fri, 13 Jul 2001 05:09:21 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Joerg Schmitz-Linneweber <jsl@sth.ruhr-uni-bochum.de>
Organization: Ruhr-Universitaet Bochum, Lehrstuhl fuer Signaltheorie
To: Linus Torvalds <torvalds@transmeta.com>,
        Gunther Mayer <Gunther.Mayer@t-online.de>
Subject: Re: Patch(2.4.6):serial unmaintained (bugfix pci timedia/sunix/exsys pci cards)
Date: Fri, 13 Jul 2001 11:09:16 +0200
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>, <tytso@mit.edu>
In-Reply-To: <Pine.LNX.4.33.0107120929500.6595-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0107120929500.6595-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01071311091603.25182@p14>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Am Donnerstag, 12. Juli 2001 18:31 schrieb Linus Torvalds:
> This should already be fixed in 2.4.7-pre6, can you verify that it works
> for you?
There are a lot more bugs (and "send-in" patches to Ted) which fix a lot of 
problems even in the 2.4.7-x driver.
I know about a guy "Ian Abbott" (abbotti at mev.co.uk) which is active on the 
serial.sf.net bug-list and has done a lot good to the serial driver. Perhaps 
he should be heard regarding this.

Personally I found a (h/w) timinig problem in the inititalisation code which 
hangs the "sunix" chips (and freezes the complete box). But since I couldn't 
get my hands on a datasheet of these chips, I've until now only solved this 
problem through a hand full of delays after "critical" I/O operations (very 
ugly).

Salut, Jörg
