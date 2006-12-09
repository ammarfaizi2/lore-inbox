Return-Path: <linux-kernel-owner+w=401wt.eu-S936275AbWLIOPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936275AbWLIOPa (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 09:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936277AbWLIOPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 09:15:30 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:46952 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S936275AbWLIOP3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 09:15:29 -0500
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: VCD not readable under 2.6.18
Date: Sat, 9 Dec 2006 16:15:21 +0200
User-Agent: KMail/1.9.5
Cc: Rakhesh Sasidharan <rakhesh@rakhesh.com>, rakheshster@yahoo.com,
       linux-kernel@vger.kernel.org
References: <20061209060602.98025.qmail@web57812.mail.re3.yahoo.com> <20061209132120.7af3ce66@localhost.localdomain>
In-Reply-To: <20061209132120.7af3ce66@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612091615.22435.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

09 Ara 2006 Cts 15:21 tarihinde, Alan şunları yazmıştı: 
> > I didn't see any responses after the post linked to above, so I'd like to
> > add that I too get this problem and that I've tried with various VCDs and
> > players. In previous versions of these distros I could just mount the VCD
> > and copy the *.DAT files across; but in the current versions I can't even
> > mount! dmesg gets flooded with errors such as the below:
> >
> >
> >
> > hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> > hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
> > ide: failed opcode was: unknown
> > ATAPI device hdc:
> >   Error: Illegal request -- (Sense key=0x05)
> >   Illegal mode for this track or incompatible medium -- (asc=0x64,
> > ascq=0x00) The failed "Read 10" packet command was:
> >   "28 00 00 00 73 f2 00 00 01 00 00 00 00 00 00 00 "
>
> Your system tried to read a Video data block. The usual cure for this
> problem is to remove Gnome, or at least kill all the Gnome stuff and flip
> to init level 3 then mount the cd from the command line.

Well my bet is xine-lib is buggy somehow as I can reproduce this bug with 
kaffeine ( KDE media player ).

Regards,
ismail
