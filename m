Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWDUO7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWDUO7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWDUO7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:59:52 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:42189 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932345AbWDUO7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:59:51 -0400
In-Reply-To: <84144f020604210742j69222654s5ec68f34ea96999c@mail.gmail.com>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com, penberg@gmail.com
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OFB753A28F.DD67C970-ON42257157.0051D51C-42257157.0052637A@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Fri, 21 Apr 2006 16:59:54 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 21/04/2006 17:00:50
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

> I have included some review comments below.

First of all thank you very much for the code review! You suggestions
sound reasonable! I will post an updated patch on Monday!

[snip]

> > +struct x_info_blk_hdr {
> > +   __u8  npar;
> > +   __u8  flags;
> > +   __u16 tslice;
> > +   __u16 phys_cpus;
> > +   __u16 this_part;
> > +   __u64 curtod1;
> > +   __u64 curtod2;
> > +   char reserved[40];
> > +} __attribute__ ((packed));
>
> Couldn't you use endianess annotated types for these?
>

What are "endianess annotated types" ?

Michael

