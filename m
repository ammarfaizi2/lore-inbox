Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946237AbWKJKCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946237AbWKJKCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946239AbWKJKCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:02:52 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:65331 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946237AbWKJKCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:02:51 -0500
In-Reply-To: <20061110065336.GA13646@kroah.com>
Subject: Re: How to document dimension units for virtual files?
To: Greg KH <greg@kroah.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, pavel@ucw.cz,
       Randy Dunlap <randy.dunlap@oracle.com>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF6928B06C.594331CB-ON41257222.0035C1AB-41257222.003747B5@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Fri, 10 Nov 2006 11:03:48 +0100
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 10/11/2006 11:05:52
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Greg KH <greg@kroah.com> wrote on 11/10/2006 07:53:36 AM:

> On Wed, Nov 08, 2006 at 07:27:56PM +0100, Michael Holzheu wrote:
> > If you want to export data to userspace via a virtual filesystem
> > like sysfs, the following rules are recommended:
>
> Um, does this mean you expect us to change all of the currently existing
> sysfs file names?  And people get mad at me when I just move sysfs
> symlinks around...

No, of course we should not change existing kernel interfaces.

> Look at the hwmon drivers, and the documentation in
> Documentation/hwmon/sysfs-interface for a description of how we have
> been documenting this already.

Yes, it is an option to document units in seperate files. But I personally
think,
that this is only the second best solution. Especially since normally
documentation is not read.

>
> In short, I don't really think we need to encode the units in the file
> name, somehow we have done pretty well without it so far :)

Why not trying to make things better than they used to be?

At least for our s390_hypfs I would like to use the suggested naming
scheme. It is new and therefore not burdened with other naming
conventions. Ok?

So, no "Documentation/filesystems/ExportData" patch?

Michael

