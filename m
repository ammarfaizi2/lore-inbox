Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164015AbWLGXqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164015AbWLGXqh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164014AbWLGXqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:46:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53273 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164015AbWLGXqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:46:36 -0500
Date: Thu, 7 Dec 2006 15:45:45 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: single bit errors on files stored on USB-HDDs via
 USB2/usb_storage
Message-Id: <20061207154545.6eb516c4.zaitcev@redhat.com>
In-Reply-To: <45786E58.5070308@citd.de>
References: <Pine.LNX.4.44L0.0612071306180.3537-100000@iolanthe.rowland.org>
	<45786E58.5070308@citd.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2006 20:41:12 +0100, Matthias Schniedermeyer <ms@citd.de> wrote:

> >>I'm using a Bunch auf HDDs in USB-Enclosures for storing files.
> >>(currently 38 HDD, with a total capacity of 9,5 TB of which 8,5 TB is used)
> >>[....]
> >>This time i kept the defective files and used "vbindiff" to show me the
> >>difference. Strangly in EVERY case the difference is a single bit in a
> >>sequence of "0xff"-Bytes inside a block of varing bit-values that
> >>changed a "0xff" into a "0xf7".

> > This was almost certainly caused by hardware flaws in the USB interface 
> > chips of the enclosures.  There's nothing the kernel can do about it 
> > because the errors aren't reported; all that happens is that incorrect 
> > data is sent to or from the drive.
> 
> So pretty much all ich can do is to pray that the errors don't corrupt
> the Filesystem-Metadata (XFS).

No, this is not all. You should buy a variety of different enclosures
with different chipsets (e.g. find a Freecom if you can), and also
use decent cables.

-- Pete
