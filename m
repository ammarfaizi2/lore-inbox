Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTLYQYq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 11:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTLYQYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 11:24:46 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:53450 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264319AbTLYQYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 11:24:45 -0500
From: dan carpenter <error27@email.com>
To: Carlo <devel@integra-sc.it>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: Ooops with kernel 2.4.22 and reiserfs
Date: Thu, 25 Dec 2003 04:34:42 -0800
User-Agent: KMail/1.5.4
References: <1072126808.21200.3.camel@atena> <200312222205.hBMM5vLv012067@car.linuxhacker.ru> <1072173894.21198.36.camel@atena>
In-Reply-To: <1072173894.21198.36.camel@atena>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312250433.50550.error27@email.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 December 2003 02:04 am, Carlo wrote:
> Il lun, 2003-12-22 alle 23:05, Oleg Drokin ha scritto:
> > Hello!
> >
> > C> hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
> > C> DataRequest }
> > C> ide0: Drive 0 didn't accept speed setting. Oh, well.
> > C> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> > C> hda: CHECK for good STATUS
> >

I would check for SMARTerrors:  smartctl -a /dev/hda 
Also you could try running badblocks on the drive.

regards,
dan carpenter




