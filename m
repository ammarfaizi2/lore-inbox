Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVASMdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVASMdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 07:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVASMdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 07:33:38 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:44930 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S261708AbVASMdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 07:33:36 -0500
Date: Wed, 19 Jan 2005 13:33:15 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Adam Radford <aradford@amcc.com>
Subject: Re: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
In-Reply-To: <20050119110902.GA12903@infradead.org>
Message-ID: <Pine.LNX.4.30.0501191309500.20626-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005, Christoph Hellwig wrote:

> > > > It looks like in the 3ware driver the procfs entry "/proc/scsi/3w-xxxx"
> > > > has been removed (or actually moved to sysfs).
> > > > Unfortunately, this breaks all the (binary only )-: tools provided by
> > > > 3ware, which are indispensable for system maintenance.
> > >
> > > The change came from the driver maintainer at 3ware.  Get the updated
> > > tools from their website.
> >
> > Which website do you mean? The programs in the download section of
> > "www.3ware.com" are just the ones that don't work anymore.
>
> It's there just a little hidden.  Adam, any chance the new managment tools
> could be placed more promimently on the website?

I guess you mean "3ware CLI (version 2.00.00.042+)"?

If this is meant to replace all the other versions on the website, then
the presentation is definitely "suboptimal", because the only way to get
there is to explicitly request "experimental" software for the "9000
series" which is kind of strange if you're just looking for basic
functionality for other controllers.

At least on my 8506-controllers there are also some minor problems (e.g.
"info" doesn't work during a verify) which I thought was due to the fact
that the program is intended exclusively for 9000-controllers.

Regards,
              Peter Daum


