Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317865AbSGVS25>; Mon, 22 Jul 2002 14:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317866AbSGVS24>; Mon, 22 Jul 2002 14:28:56 -0400
Received: from cdt1.tz-juelich.de ([195.37.52.66]:11206 "EHLO www.credativ.de")
	by vger.kernel.org with ESMTP id <S317865AbSGVS2z>;
	Mon, 22 Jul 2002 14:28:55 -0400
Date: Mon, 22 Jul 2002 20:34:03 +0200
From: Michael Meskes <michael.meskes@credativ.de>
To: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: Oliver Korff <oliver.korff@credativ.de>
Subject: Bug in 2.4.18?
Message-ID: <20020722183403.GA23249@feivel.credativ.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got another very strange situation, which looks like a bug in the
kernel:

Raidarrays with more than 600GB (approx.) are not correctly identified
and fdisk dumps core. Kernel 2.4.18 says:

SCSI device sda: 1289371648 512-byte hdwr sectors (-439352 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >

Needless to say that the disks do not have a negative size. :-)

BTW 2.2.21 says:

SCSI device sda: hdwr sector= 512 bytes. Sectors= 1289371648 [629576 MB] [629.6GB]

which surely looks okay.

Michael

P.S.: Please CC me on replies.

-- 
Michael Meskes
Michael@Fam-Meskes.De
Go SF 49ers! Go Rhein Fire!
Use Debian GNU/Linux! Use PostgreSQL!
