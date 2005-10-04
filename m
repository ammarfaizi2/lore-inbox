Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVJDMn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVJDMn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVJDMnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:43:09 -0400
Received: from [203.171.93.254] ([203.171.93.254]:27079 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932402AbVJDMm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:42:59 -0400
Subject: Re: Strange disk corruption with Linux >= 2.6.13
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: sander@humilis.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051004102834.GA16755@favonius>
References: <20050927111038.GA22172@ime.usp.br>
	 <1127863912.4802.52.camel@localhost> <20051001213655.GE6397@ime.usp.br>
	 <20051004102834.GA16755@favonius>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1128429739.6611.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 04 Oct 2005 22:42:20 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, 2005-10-04 at 20:28, Sander wrote:
> Rog?rio Brito wrote (ao):
> > On Sep 28 2005, Nigel Cunningham wrote:
> > > 3) Is the corruption only ever in memory, or seen on disk too?
> > 
> > I have noticed the problem mostly on disk. One strange situation was
> > when I was untarring a kernel tree (compressed with bzip2) and in the
> > middle of the extraction, bzip2 complained that the thing was
> > corrupted.
> > 
> > I removed what was extracted right away and tried again to extract the
> > tree (at this point, suspecting even that something in software had
> > problems). The problem with bzip2 occurred again. Then, I rebooted the
> > system an the problem magically went away.
> 
> That would mean the corruption existed in memory only. The kernel
> tarball got sucked into memory and got corrupted. On reboot, the tarball
> gets read in again, and this time no corruption. The on disk tarball was
> oke it seems.
> 
> If you run memtest86+ (latest version) for at least 24 hours it _should_
> find something.

Assuming that it really is a memory issue. Don't discount the
possibility of a kernel bug too quickly, especially when it apparently
worked fine in the past.

Just my 2c, feel free to discount anyway :)

Regards,

Nigel

