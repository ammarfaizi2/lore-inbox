Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271932AbTHDQvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271933AbTHDQvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:51:09 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43932 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271932AbTHDQvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:51:07 -0400
Subject: Re: DVD-RAM errors (was: DVD-RAM crashing system)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nachman Yaakov Ziskind <awacs@egps.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030804122603.B1157@egps.egps.com>
References: <20030803234706.A13048@egps.egps.com>
	 <1060002004.416.2.camel@dhcp22.swansea.linux.org.uk>
	 <20030804122603.B1157@egps.egps.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060015636.811.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Aug 2003 17:47:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-08-04 at 17:26, Nachman Yaakov Ziskind wrote:
> Alan Cox wrote (on Mon, Aug 04, 2003 at 02:00:04PM +0100):
> > On Llu, 2003-08-04 at 04:47, Nachman Yaakov Ziskind wrote:
> > > command like 'tar cvf /dev/scd0 my-files', the machine hangs for a couple 
> > > of seconds, writes nothing to DVD, and I get these errors:
> > > 
> > > Aug  3 13:40:08 gemach kernel: Current sd0b:00: sense key Data Protect
> > > Aug  3 13:40:08 gemach kernel:  I/O error: dev 0b:00, sector 4
> > > Aug  3 13:40:08 gemach kernel: SCSI cdrom error : host 2 channel 0 id 0 lun
> > > 0 return code = 28000000
> > 
> > Your drive rejected the command
> 
> Well, ok, but *why*? In particular, why now, when this worked under 2.14.18-4,
> with the appropriate ide-scsi module? I'd been doing backups to this drive for
> months. I have lots of DVD's with tar data on them. I've done restores in the
> past.

Judging by the "Data Protect" the disk you are using thinks its write
protected.


