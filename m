Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271713AbTG2N2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271717AbTG2N2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:28:39 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:49545
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S271713AbTG2N2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:28:39 -0400
Date: Tue, 29 Jul 2003 09:44:28 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 NFS file transfer
Message-ID: <20030729094428.B12763@animx.eu.org>
References: <20030728225947.GA1694@localhost.localdomain> <20030729072440.A12426@animx.eu.org> <20030729130400.GA4052@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20030729130400.GA4052@localhost.localdomain>; from Balram Adlakha on Tue, Jul 29, 2003 at 06:34:00PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I cannot transfer files larger than 914 mb from an NFS mounted
> > > filesystem to a local filesystem. A larger file than that is
> > > simply cut of at 914 MB. This is using 2.6.0-test1, 2.4.20 
> > > works fine. Can it be the version of mount I'm using? Its the
> > > one that comes with util-linux-2.11y.
> > 
> > I noticed on 2.6.0-test1 that mounting a server using the userspace nfs
> > daemon (v2 I assume) doesn't work very well at all.  It was pretty much
> > useless.  I rarely ever could get a directory listing.  It would just spew
> > "nfs server not responding".

> I'll try with the kernel NFS then, any idea why this happens?

That's what I'd like to know.  I have both provide nfsv3 and nfsv4 compiled. 
I have not tried it w/o nfsv4 but I do use nfsv3.  One of my servers uses
the kernel nfsd with v3 support.

On a side note, I wish I could export / to whoever and everything seen on
the localsystem under / is exported just like the userspace daemon.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
