Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTE0VE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTE0VE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:04:26 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:11706 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264137AbTE0VEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:04:23 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Subject: Re: 2.5.69-bk13 USB storage ,few errors
Date: Tue, 27 May 2003 23:14:04 +0200
User-Agent: KMail/1.5.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <1053972173.1968.18.camel@nalesnik.localhost> <200305270007.16492.oliver@neukum.org> <1053987543.3650.11.camel@nalesnik.localhost>
In-Reply-To: <1053987543.3650.11.camel@nalesnik.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305272314.04758.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 27. Mai 2003 00:19 schrieb Grzegorz Jaskiewicz:
> On Mon, 2003-05-26 at 23:07, Oliver Neukum wrote:
> > Am Montag, 26. Mai 2003 23:30 schrieb Grzegorz Jaskiewicz:
> > > On Mon, 2003-05-26 at 21:05, Oliver Neukum wrote:
> > > > > this is sony vaio pcg-c1ve notebook
> > > > > USB storage on 2.4.21-rc3 does not say anything in dmesg, and works
> > > > > just perfect.
> > > >
> > > > Does it work on 2.5? Your dmesg has no errors.
> > >
> > > no, it does not on 2.5.69-bk19
> > > /dev/scsi dir is empty (devfs)
> >
> > Do you see it in /proc/scsi/scsi ?
>
> cat gj@nalesnik:~$ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: Sony     Model: MSC-U01N         Rev: 1.00
>   Type:   Direct-Access                    ANSI SCSI revision: 02
>
> gj@nalesnik:~$ ls -l /dev/scsi/
> total 0
>
> nalesnik:~# lsusb
> Bus 001 Device 002: ID 054c:0032 Sony Corp. MemoryStick MSC-U01 Reader
> Bus 001 Device 001: ID 0000:0000
>
> well, i can recompile usb system with debug and give you log.

Sorry about the delay. This is unlikely to yield useful results.
Usb-storage works. This looks like a devfs problem.

	Regards
		Oliver


