Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVBIImE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVBIImE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 03:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVBIImE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 03:42:04 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:28068 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S261685AbVBIIl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 03:41:59 -0500
Date: Wed, 9 Feb 2005 09:41:39 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Adam Radford <aradford@amcc.com>
Subject: Re: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
In-Reply-To: <Pine.LNX.4.30.0501191309500.20626-100000@swamp.bayern.net>
Message-ID: <Pine.LNX.4.30.0502090919380.8847-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... a little addendum:

while the mentioned "experimental" tw_cli (2.00.00.042) provides at
least basic functionality for some controllers (I mostly use 8506-8)
it does not work at all with 8506-4 controllers (It just complains
"No controller found").

Regards,
             Peter Daum

On Wed, 19 Jan 2005, Peter Daum wrote:

> On Wed, 19 Jan 2005, Christoph Hellwig wrote:
>
> > > > > It looks like in the 3ware driver the procfs entry "/proc/scsi/3w-xxxx"
> > > > > has been removed (or actually moved to sysfs).
> > > > > Unfortunately, this breaks all the (binary only )-: tools provided by
> > > > > 3ware, which are indispensable for system maintenance.
> > > >
> > > > The change came from the driver maintainer at 3ware.  Get the updated
> > > > tools from their website.
> > >
> > > Which website do you mean? The programs in the download section of
> > > "www.3ware.com" are just the ones that don't work anymore.
> >
> > It's there just a little hidden.  Adam, any chance the new managment tools
> > could be placed more promimently on the website?
>
> I guess you mean "3ware CLI (version 2.00.00.042+)"?
>
> If this is meant to replace all the other versions on the website, then
> the presentation is definitely "suboptimal", because the only way to get
> there is to explicitly request "experimental" software for the "9000
> series" which is kind of strange if you're just looking for basic
> functionality for other controllers.
>
> At least on my 8506-controllers there are also some minor problems (e.g.
> "info" doesn't work during a verify) which I thought was due to the fact
> that the program is intended exclusively for 9000-controllers.


