Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313033AbSC0P3A>; Wed, 27 Mar 2002 10:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313035AbSC0P2v>; Wed, 27 Mar 2002 10:28:51 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:55680 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S313033AbSC0P2k>; Wed, 27 Mar 2002 10:28:40 -0500
Message-Id: <200203271528.g2RFSZM10812@fubini.pci.uni-heidelberg.de>
Content-Type: text/plain; charset=US-ASCII
From: Bernd Schubert <bernd-schubert@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: time jumps
Date: Wed, 27 Mar 2002 16:28:35 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have a computer here, that behaves very strange, from one second to 
another the clock changes to about 1h in the future. In the next "real" 
second the time is normal again. 
Well, I first thought that is might be a X problem, but after running a loop 
over "date", it really seems that the system clock is affected.  Then I 
thought it might be a conflict with the hardware clock, but after resetting 
it to the system time, the problem was still there.

The only clock that doesn't seem to be affected is the realtime clock (at 
least not when doing a loop of cat over the proc-file).

The problem is, that this time jumps cause the Xserver to enable its 
screensaver (and several other small problems).

System  is: Athlon 650 on VIA board with linux-2.4.17 (unpatched)


So has anyone an idea what to do, I'm thinking about a BIOS update (but don't 
really believe that it will help). Or is it possible to patch the kernel that 
it uses the realtime clock (could anyone of you send me this patch, if it is 
possible, please??).


Of course, I can give further information, if needed.

Thanks in advance, Bernd
