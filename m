Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131510AbRCNUJr>; Wed, 14 Mar 2001 15:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131513AbRCNUJj>; Wed, 14 Mar 2001 15:09:39 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:37294 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S131510AbRCNUJX>;
	Wed, 14 Mar 2001 15:09:23 -0500
Date: Wed, 14 Mar 2001 15:08:40 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Christoph Hellwig <hch@caldera.de>
cc: <linux-kernel@vger.kernel.org>, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
In-Reply-To: <200103141823.TAA11310@ns.caldera.de>
Message-ID: <Pine.SGI.4.31L.02.0103141507230.3571740-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001, Christoph Hellwig wrote:

> In article <Pine.SGI.4.31L.02.0103141026460.532128-100000@irix2.gl.umbc.edu> you wrote:
>
> > The problem:
>
> > drivers change their detection schemes; and changes in the kernel can
> > change the order in which devices are assigned names.
> >
> > For example, the DAC960(?) drivers changed their order of
> > detecting controllers, and I did _not_ have fun, given that the machine in
> > question had about 40 disks to deal with, spread across two controllers.
>
> Put LABEL=<label set with e2label> in you fstab in place of the device name.

It solves the example, but not necessarily the problem.

We're still left with partitions that don't do labels, attached tape
devices, scsi controllers, NICs, and so forth.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

