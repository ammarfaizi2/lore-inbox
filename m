Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754648AbWKHS07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648AbWKHS07 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbWKHS07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:26:59 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:46380 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1754647AbWKHS06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:26:58 -0500
In-Reply-To: <20061108090454.dba20e01.randy.dunlap@oracle.com>
Subject: Re: How to document dimension units for virtual files?
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, pavel@ucw.cz
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF2A3BB933.427A044B-ON41257220.006509CA-41257220.00656F8A@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 8 Nov 2006 19:27:56 +0100
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 08/11/2006 19:30:01
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,

Randy Dunlap <randy.dunlap@oracle.com> wrote on 11/08/2006 06:04:54 PM:

> On Wed, 8 Nov 2006 17:54:12 +0100 Michael Holzheu wrote:

[snip]

> 01:00:00.000000000 +0100
> > +++ linux-2.6.18-exp-data-doc/Documentation/filesystems/ExportData
> 2006-11-08 17:44:59.000000000 +0100
> > @@ -0,0 +1,47 @@
> > +
> > +Export data via virtual File Systems
> > +====================================
> > +
> > +If you want to export data to userspace via virtual filesystems
> > +like procfs, sysfs, debugfs etc., the following rules are recommended:
> > +
> > +- Export only one value in one virtual file.
>
> I don't think that makes sense for procfs.  It's too late,
> but even it weren't, we don't need a large increase in the number
> of procfs files.
>
> And debugfs shouldn't be constrained either.
> It's not a regular user interface like sysfs is.
>

Ok, fine:

If you want to export data to userspace via a virtual filesystem
like sysfs, the following rules are recommended:

....

Michael

