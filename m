Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUFNIQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUFNIQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUFNIQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:16:13 -0400
Received: from [213.146.154.40] ([213.146.154.40]:24529 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262079AbUFNIPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:15:00 -0400
Date: Mon, 14 Jun 2004 09:14:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [8/12] fake inquiry for Sony Clie PEG-TJ25 in unusual_devs.h
Message-ID: <20040614081459.GG7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040614004034.GV1444@holomorphy.com> <20040614004147.GW1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614004147.GW1444@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 05:41:47PM -0700, William Lee Irwin III wrote:
>  * Fake inquiry for Sony Clie PEG-TJ25 in drivers/usb/storage/unusual_devs.h
> This fixes Debian BTS #243650.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=243650
> 
> 	From: Mike Alborn <malborn@deandra.homeip.net>
> 	To: Debian Bug Tracking System <submit@bugs.debian.org>
> 	Subject: kernel-image-2.6.5-1-686: usb-storage fails to enumerate Sony Clie PEG-TJ25
> 	Message-Id: <E1BDet8-0000ND-00@dominique>
> 
> When I connect my Sony Clie PEG-TJ25 to my computer and run the MS
> Import function, the usb-storage module reports the following error:
> 
> scsi0 : SCSI emulation for USB Mass Storage devices 
> scsi scan: 56 byte inquiry failed with code 134217730. Consider
> BLIST_INQUIRY_36 for this device.
> 
> lsusb shows the Clie device, but when I try to mount /dev/sda1, I get
> '/dev/sda1 is not a valid block device' and cfdisk is 'unable to open
> /dev/sda' I have no other SCSI hard disks installed on the system, so I
> assume /dev/sda1 is where I should find my Clie.
> 
> Note that this function worked with a Debian package of a 2.4 kernel (I
> believe it was 2.4.24).

This one is already in for some time.

