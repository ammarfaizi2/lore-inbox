Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWJQUaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWJQUaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWJQUaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:30:46 -0400
Received: from dxv01.wellsfargo.com ([151.151.5.42]:64218 "EHLO
	dxv01.wellsfargo.com") by vger.kernel.org with ESMTP
	id S1751246AbWJQUap convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:30:45 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: Touchscreen hardware hacking/driver hacking.
Date: Tue, 17 Oct 2006 15:30:43 -0500
Message-ID: <E8C008223DD5F64485DFBDF6D4B7F71D020C5E83@msgswbmnmsp25.wellsfargo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Touchscreen hardware hacking/driver hacking.
Thread-Index: AcbyKxw2Q/Mp7F99RUaKI0Ab6CYmpg==
From: <Greg.Chandler@wellsfargo.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Oct 2006 20:30:44.0166 (UTC) FILETIME=[1ED88660:01C6F22B]
X-WFMX: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working on a prototype Hitachi tablet, it uses a Fujitsu 4-wire
resistive touchscreen. {10.4" I think}
I've found that windows-xp embedded uses a generic ps/2 driver for the
device.

I've ripped this thing to pieces on several occasions looking for chips
to help the porting, my problem is that I can not find the
analog-digital converter for this thing.  The connector goes to a
surface mount header on an 8 layer board.
I loose the traces almost instantly.  Given that I can't find the
converter anywhere what should I do next?

I've done my homework and found that this HAS to be either serial or usb
attached according to Fujitsu.
Aparently it's neither.  There are no unknown USB devices {or known
matching}, and there is no activity on the single serial port on the
system.  Since the windows driver uses PS/2 as the interface I have a
horrible feeling this thing has an interpretation layer that makes it a
PS/2 mouse, and that may or may not royally be a nightmare.

I would have posted this to a different group but there is no "input"
mailing list.

Help?


I'll give a reward to anyone willing to actually help me get this hacked
out.
Reward defined:
  Permanent shell access to my personal development envirnoment for
testing kernel code.
  Equipment in the environment: ARM, Alpha, x86-32, MIPS/Origin, HPPA,
SPARC, PPC

--Greg Chandler
