Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269462AbUINWif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269462AbUINWif (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUINWer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:34:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:18640 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269653AbUINWXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:23:04 -0400
Date: Tue, 14 Sep 2004 15:18:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to find out which kernel release contains some code
Message-Id: <20040914151836.5d15e4f0.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0409131132570.3202-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0409131132570.3202-100000@ida.rowland.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 11:41:50 -0400 (EDT) Alan Stern wrote:

| Randy:
| 
| Is there any simple easy way to find out in which kernel release a 
| particular line of code first appeared?  Or to find out whether that line 
| is or isn't present in a particular release?

Hi Alan,

I usually try to use BK's web interface "Browse the source tree"
for this:
  http://linux.bkbits.net:8080/linux-2.5/src?nav=index.html

E.g., I can browse uhci-hcd.c, version 1.89, and see on what date
and who it thinks was responsible for a line of source code:
http://linux.bkbits.net:8080/linux-2.5/anno/drivers/usb/host/uhci-hcd.c%401.89?nav=index.html|src/.|src/drivers|src/drivers/usb|src/drivers/usb/host
But that won't say what kernel version it is (first) contained in.
Just a merge date.

| The timestamps in BitKeeper don't help much.  They seem to reflect the 
| first time the code was put into _any_ BitKeeper repository, not the time 
| it was entered into Linus's tree.

Yes, that bugs me too.

| The web interface to the linux-2.6 tree 
| doesn't offer any way to view a particular source file as of a particular 
| release tag.
| 
| I don't fancy downloading lots and lots of enormous patch files, searching
| for one small entry.  Or lots of kernel source tarballs, for that matter.
| 
| There's got to be an easier way.  Do you know of one?

Not really.  You could ask on the bk-users mailing list.  See here:
  http://www.bitkeeper.com/Support.Mailing.html

Or there may be features in the commercial version of BK that help
out with this more that the free version does.  I dunno.

--
~Randy
