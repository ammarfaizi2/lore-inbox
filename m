Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVAKRrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVAKRrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVAKRrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:47:48 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:39892 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262871AbVAKRPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:15:47 -0500
Subject: Re: Unable to burn DVDs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Laurent CARON <lcaron@apartia.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501110802180.8535@yvahk01.tjqt.qr>
References: <41E2F823.1070608@apartia.fr>
	 <Pine.LNX.4.61.0501110802180.8535@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105458043.15794.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 11 Jan 2005 16:11:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-11 at 07:08, Jan Engelhardt wrote:
> > WARNING: /dev/scd0 already carries isofs!
> > About to execute 'mkisofs -R -J /root/sendmail.mc | builtin_dd of=/dev/scd0
> > obs=32k seek=0'
> > INFO:ingISO-8859-15 character encoding detected by locale settings.
> > Assuming ISO-8859-15 encoded filenames on source filesystem,
> > use -input-charset to override.
> > Total translation table size: 0
> > Total rockridge attributes bytes: 252
> > Total directory bytes: 0
> > Path table size(bytes): 10
> > /dev/scd0: "Current Write Speed" is 4.1x1385KBps.
> > : -[ WRITE@LBA=0h failed with SK=4h/ASC=08h/ACQ=03h]: Input/output error
> > : -( write failed: Input/output error
> >
> > Needless to say it works fine with 2.6.9
> > Am I missing something?
> 
> /dev/hdX of course won't work if ide-scsi is loaded, I guess.

Its using /dev/scd0 which is just fine. It also read the volume
successfully since it was able to warn that the drive already had an fs
and to get the write speed and other properties.


