Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVDCJvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVDCJvx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 05:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVDCJvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 05:51:53 -0400
Received: from host207-193-149-62.serverdedicati.aruba.it ([62.149.193.207]:6086
	"EHLO chernobyl.investici.org") by vger.kernel.org with ESMTP
	id S261635AbVDCJvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 05:51:51 -0400
Subject: Re: Problem mounting dvd if the drive spin down
From: Nate Grey <nate@paranoici.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050402113012.6a1b3880.akpm@osdl.org>
References: <1112459636.15372.18.camel@maggot.MetalZone.lan>
	 <20050402113012.6a1b3880.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 03 Apr 2005 11:51:46 +0200
Message-Id: <1112521906.3809.10.camel@maggot.MetalZone.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-02 at 11:30 -0800, Andrew Morton wrote:

> Did it work OK under any other kernel versions?  If so, which?

At least it works in 2.6.7, I jump from .7 to .9 then .10 and
finally .11, I notice this problem in 2.6.10 firstly.

If you need addictional info about the drive just ask.

I forgot to say that at boot time hdparm is run on the device:

hdparm -c1 -d1 -u1 -X66 /dev/hdc


Thank you.


P.S.

hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=0x40 { LastFailedSense=0x04 }
ide: failed opcode was: unknown
hdc: ide_intr: huh? expected NULL handler on exit
hdc: ATAPI reset complete
end_request: I/O error, dev hdc, sector 64
isofs_fill_super: bread failed, dev=hdc, iso_blknum=16, block=16


