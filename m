Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTEZWYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTEZWYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:24:43 -0400
Received: from pointblue.com.pl ([62.89.73.6]:37636 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262319AbTEZWSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:18:12 -0400
Subject: Re: 2.5.69-bk13 USB storage ,few errors
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Oliver Neukum <oliver@neukum.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200305270007.16492.oliver@neukum.org>
References: <1053972173.1968.18.camel@nalesnik.localhost>
	 <200305262205.38256.oliver@neukum.org>
	 <1053984606.3650.0.camel@nalesnik.localhost>
	 <200305270007.16492.oliver@neukum.org>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1053987543.3650.11.camel@nalesnik.localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 23:19:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-26 at 23:07, Oliver Neukum wrote:
> Am Montag, 26. Mai 2003 23:30 schrieb Grzegorz Jaskiewicz:
> > On Mon, 2003-05-26 at 21:05, Oliver Neukum wrote:
> > > > this is sony vaio pcg-c1ve notebook
> > > > USB storage on 2.4.21-rc3 does not say anything in dmesg, and works
> > > > just perfect.
> > >
> > > Does it work on 2.5? Your dmesg has no errors.
> >
> > no, it does not on 2.5.69-bk19
> > /dev/scsi dir is empty (devfs)
> 
> Do you see it in /proc/scsi/scsi ?
cat gj@nalesnik:~$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Sony     Model: MSC-U01N         Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02

gj@nalesnik:~$ ls -l /dev/scsi/
total 0

nalesnik:~# lsusb
Bus 001 Device 002: ID 054c:0032 Sony Corp. MemoryStick MSC-U01 Reader
Bus 001 Device 001: ID 0000:0000

well, i can recompile usb system with debug and give you log.


-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

