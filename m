Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbTAZIJ2>; Sun, 26 Jan 2003 03:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbTAZIJ2>; Sun, 26 Jan 2003 03:09:28 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47113
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266735AbTAZIJ1>; Sun, 26 Jan 2003 03:09:27 -0500
Date: Sun, 26 Jan 2003 00:13:39 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Manish Lachwani <m_lachwani@yahoo.com>
cc: Bryan Andersen <bryan@bogonomicon.net>, linux-kernel@vger.kernel.org
Subject: Re: FW: PDC202XX DMA loss in 2.4.21-pre3-ac4
In-Reply-To: <20030126071524.57299.qmail@web20509.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10301252349550.1744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003, Manish Lachwani wrote:

> The "Hardware ECC Recovered" indicates the number of
> ECC errors corrected in the drive. Do one thing. Try
> to swap the drive with the drive on another ATA cable.
> So, swap /dev/hde with /dev/hda (or whatever)
> physically and check if the error follows the drive or
> the ATA cable. 
> 
> If it follows the drive, you may have to replace the
> drive. Additionally, from the SMART error log #5:
> 
> 00   04   01   0b   4f   c2    e0   51     279972

NO!
       command aborted
            amount to transfer == 1 sector
                 have to dig through notes to decode ...
                      lcyl smart passcode
                           hcyl smart passcode
                                 primary device
                                      ready_seek_error


It barfed the command ...

try -e first

Cheers,

Andre Hedrick
LAD Storage Consulting Group



