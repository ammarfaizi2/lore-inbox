Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264439AbTLQPc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 10:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbTLQPc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 10:32:59 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:59805
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S264439AbTLQPc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 10:32:57 -0500
Date: Wed, 17 Dec 2003 10:40:36 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031217104036.A13292@animx.eu.org>
References: <20031212131704.A26577@animx.eu.org> <20031212194439.GB11215@win.tue.nl> <20031216135306.GA7292@iliana> <200312161717.hBGHH0kX000201@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <200312161717.hBGHH0kX000201@81-2-122-30.bradfords.org.uk>; from John Bradford on Tue, Dec 16, 2003 at 05:17:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I believe parted does not. Nor any of the libparted frontends. I may be
> > wrong though.
> 
> If so, I consider it a missing feature in parted - why should the BIOS
> geometry resemble the disk it describes at all?  Some machines have no
> user-definable drive types, forcing you to use an incorrect geometry
> if you install a disk which is not in the table of supported drives.
> 
> This is no problem for recent Linux kernels, and doesn't even prevent
> you booting from that disk.

I think noone has really understood why I want it.  The machines in question
will not ever boot linux from the hard disk.  Only from the CD that I built. 
The OS that is installed from the CD is one of the windows OSs which depend
on the bios geometry definition to boot properly.  The kernel doesn't care
about the geometry, that's all well and good except when I create the
partitions.  Most of the pcs I work with use */255/63 notation,
occasionally, I'll come across one that uses */128/63 notation.  Never one
with */16/63 notation.  The smallest disk I work with would be a 1.2gb disk.

I have tried to make this CD as simple to use as possible, which means
passing the geometry on the command line is out of the question and setting
it for every invocation of *fdisk is pretty much out as well.  I liked the
"bogus bios"geometry the kernel was able to get from the bios.  Out of the
hundreds of PCs I've used this on, not one has ever failed me.

I have stuck with 2.4.x for now, but at some point, it'll have to be
upgraded due to hardware support.  2.4 will eventtually become with 2.0 is
now, stable, no new drives, only critial bug fixes.  As time progresses, the
kernel will not support newer hardware (For instance network drivers which
is used havily in this CD as well).

All I really want is to beable to get the kernel to get the bios parameters
for me.  If this means a patch or something, that's fine.  (I don't know
anything about the ide drivers to do this)

This CD has made my life easier at my job and it's not something I want to
give up while I still have this job =)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
