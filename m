Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTKIDuS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 22:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTKIDuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 22:50:18 -0500
Received: from [62.67.222.139] ([62.67.222.139]:63466 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S262149AbTKIDuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 22:50:14 -0500
Date: Sun, 9 Nov 2003 04:49:40 +0100
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird partititon recocnising problem in 2.6.0-testX
Message-ID: <20031109034940.GA8532@zappa.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
References: <20031109011205.GA21914%konsti@ludenkalle.de> <20031109023625.GA15392@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031109023625.GA15392@win.tue.nl>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
X-Spam-Score: 3.3
X-Spam-Report: Spam detection software, running on the system "kermit", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	admin@mail.ku-gbr.de for details.
	Content preview:  * Andries Brouwer <aebr@win.tue.nl> [Sun, Nov 09, 2003
	at 03:36:25AM +0100]: > > hda: hda hda2 > > I suppose that second hda
	is a typo for hda1? Yes ;) [...] 
	Content analysis details:   (3.3 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 RCVD_IN_NJABL_DIALUP   RBL: NJABL: dialup sender did non-local SMTP
	[217.227.70.105 listed in dnsbl.njabl.org]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[Dynamic/Residential IP range listed by]
	[easynet.nl DynaBlock - <http://dynablock.easynet.nl/errors.html>]
	0.1 RCVD_IN_NJABL          RBL: Received via a relay in dnsbl.njabl.org
	[217.227.70.105 listed in dnsbl.njabl.org]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[217.227.70.105 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andries Brouwer <aebr@win.tue.nl> [Sun, Nov 09, 2003 at 03:36:25AM +0100]:

> > hda: hda hda2
> 
> I suppose that second hda is a typo for hda1?

Yes ;)

> What partition table? (fdisk -l /dev/hda or sfdisk -l -x -uS /dev/hda)

	 Disk /dev/hda: 255 heads, 63 sectors, 1245 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       365   2931831   83  Linux
/dev/hda2           366      1245   7068600    5  Extended
/dev/hda5           366       487    979933+  83  Linux
/dev/hda6          1185      1245    489951   82  Linux swap

Disk /dev/hdb: 255 heads, 63 sectors, 16709 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdb1             1     16709 134215011   83  Linux


Thats it :) 

.config is at
http://ludenkalle.de/.config

Konsti
