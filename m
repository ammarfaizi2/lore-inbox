Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbWECIsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWECIsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 04:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWECIsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 04:48:12 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:44041 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965130AbWECIsM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 04:48:12 -0400
In-Reply-To: <20060429011423.7db4075a.akpm@osdl.org>
Subject: Re: [PATCH] s390: Hypervisor File System
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF10257691.2976B094-ON42257163.00301DAA-42257163.00305E96@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 3 May 2006 10:48:19 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/05/2006 10:49:21
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton <akpm@osdl.org> wrote on 04/29/2006 10:14:23 AM:

[snip]

> >  > Also, "/sys/hypervisor" is probably insufficiently specific.  In a
few
> >  > years time people will be asking "Which hypervisor?  We have
> eighteen of them!".
> >
> >  I agree, the xen people are already clammering for some kind of sysfs
> >  tree and wanted to create /sys/hypervisor/xen.  How about
> >  /sys/hypervisor/s390?

Fine with me! Then I will create /sys/hypervisor/s390. Should I
create /sys/hypervisor in the hpyfs code or should it be
created somewhere else?

> Yes, something like that.  Even "hypfs" is possibly too generic.

What about s390-hypfs?

Michael

