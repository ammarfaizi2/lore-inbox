Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTLPRLd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTLPRLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:11:33 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1920 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261950AbTLPRL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:11:29 -0500
Date: Tue, 16 Dec 2003 17:17:00 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312161717.hBGHH0kX000201@81-2-122-30.bradfords.org.uk>
To: Sven Luther <sven.luther@wanadoo.fr>, Andries Brouwer <aebr@win.tue.nl>
Cc: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20031216135306.GA7292@iliana>
References: <20031212131704.A26577@animx.eu.org>
 <20031212194439.GB11215@win.tue.nl>
 <20031216135306.GA7292@iliana>
Subject: Re: 2.6 and IDE "geometry"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Sven Luther <sven.luther@wanadoo.fr>:
> On Fri, Dec 12, 2003 at 08:44:39PM +0100, Andries Brouwer wrote:
> > On Fri, Dec 12, 2003 at 01:17:04PM -0500, Wakko Warner wrote:
> > 
> > > Is there anyway to get kernel 2.6 to use the geometry
> > > the bios has for an IDE drive?
> > 
> > The kernel does not use any geometry.
> > 
> > > I have a installation setup that installs a non-linux os and I partition the
> > > drive under linux.  In 2.4 this has worked flawlessly, however, 2.6 reports
> > > as # cylinders/16 heads/63 sectors.
> > 
> > Aha. So your real question is:
> > "Is there any way to get *fdisk to use my favorite geometry?"
> > The answer is: all common fdisk versions allow you to set the geometry.
> 
> I believe parted does not. Nor any of the libparted frontends. I may be
> wrong though.

If so, I consider it a missing feature in parted - why should the BIOS
geometry resemble the disk it describes at all?  Some machines have no
user-definable drive types, forcing you to use an incorrect geometry
if you install a disk which is not in the table of supported drives.

This is no problem for recent Linux kernels, and doesn't even prevent
you booting from that disk.

John.
