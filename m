Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTLSVuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 16:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTLSVuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 16:50:04 -0500
Received: from pop.gmx.de ([213.165.64.20]:647 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263625AbTLSVuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 16:50:00 -0500
X-Authenticated: #20450766
Date: Fri, 19 Dec 2003 22:16:33 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: SCSI AM53C974 driver missing in 2.6.0?
In-Reply-To: <20031219095647.18648118.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0312192210550.3888-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003, Randy.Dunlap wrote:

> On Thu, 18 Dec 2003 15:55:27 +0100 Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> wrote:
>
> | in 2.4.x we've been using
> | CONFIG_SCSI_AM53C974=m
> |
> | 2.6.0 doesn't seem to have any support for that specific SCSI
> | controller. What now? Aternatives?
>
> Kurt Garloff <garloff@suse.de>
> and Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> have made some recent patches for this driver.
> It was discussed on the linux-scsi@vger.kernel.org mailing list.

tmscsim driver should be used in 2.6. I've posted the "final" version of a
patch to this driver on linux-scsi. Kurt wanted to put it on his site for
download, so, maybe it's there. Otherwise have a look in linux-scsi
archives. It should be included in 2.6 at some point, possibly, 2.6.1...

Guennadi

P.S. heh, this is becomming a FAQ:-)) Looks like there are a couple more
users of this driver / chip then I initially thought:-)
---
Guennadi Liakhovetski



