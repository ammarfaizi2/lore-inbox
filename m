Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131484AbRC3QAI>; Fri, 30 Mar 2001 11:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbRC3P76>; Fri, 30 Mar 2001 10:59:58 -0500
Received: from mehl.gfz-potsdam.de ([139.17.1.100]:43215 "EHLO
	mehl.gfz-potsdam.de") by vger.kernel.org with ESMTP
	id <S131486AbRC3P7n> convert rfc822-to-8bit; Fri, 30 Mar 2001 10:59:43 -0500
Date: Fri, 30 Mar 2001 17:59:00 +0200
From: Steffen Grunewald <steffen@gfz-potsdam.de>
To: linux-kernel@vger.kernel.org
Subject: Cool Road Runner
Message-ID: <20010330175900.I1396@dss19>
Mail-Followup-To: Steffen Grunewald <steffen>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Disclaimer: I don't speak for no one else. And vice versa
X-Operating-System: SunOS
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by dss19.gfz-potsdam.de id RAA22638
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

we're trying to get a Cool Road Runner board by Lippert (see 
http://www.emjembedded.com/products/single/coolroadr.html)
to run under Linux (SuSE 6.4, kernel 2.2.14).

The CompactFlash disk (a 32 MB SanDisk) is recognized as /dev/hda,
but the system fails to see the /dev/hdb disk (an IBM DARA-206000
jumpered as slave). When the IDE driver loads, it displays 
hda:pio, hdb:DMA - and yes, the BIOS assigns UDMA33 to the slave drive
while the master is detected as Mode1.
The IDE controller is a CS5530.

Is there a chance that a newer kernel will detect the second disk?

If I disconnect the slave drive, I can see "hdb:pio" :-((( but not
the drive, of course B-)

Any ideas?

Steffen
-- 
 Steffen Grunewald | GFZ | PB 2.2 | Telegrafenberg E3 | D-14473 Potsdam
 » email: steffen(at)gfz-potsdam.de | fax/fon: +49-331-288-1266/-1245 «
    It has just been discovered that research causes cancer in rats.
