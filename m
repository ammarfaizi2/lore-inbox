Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288300AbSACUfq>; Thu, 3 Jan 2002 15:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288304AbSACUfh>; Thu, 3 Jan 2002 15:35:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:7875 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288300AbSACUfX>;
	Thu, 3 Jan 2002 15:35:23 -0500
Date: Thu, 3 Jan 2002 15:35:19 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Jones <davej@suse.de>
cc: Pavel Machek <pavel@suse.cz>, Daniel Phillips <phillips@bonn-fries.net>,
        Andrew Morton <akpm@zip.com.au>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Keith Owens <kaos@ocs.com.au>,
        Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system
In-Reply-To: <Pine.LNX.4.33.0201032128090.12592-100000@Appserv.suse.de>
Message-ID: <Pine.GSO.4.21.0201031532100.23693-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Jan 2002, Dave Jones wrote:

> On Thu, 3 Jan 2002, Pavel Machek wrote:
> 
> > Being able to cp -a then build without full rebuild is good. Also make dep
> > takes  *long* and and bad things happen when you think it was not needed ;-).
> 
> And being able to NFS share 1 kernel tree, and be able to do parallel
> builds on multiple boxes without having to wait until 1 is finished.

	Sigh...  As soon as we get to prototype change in
getattr()/setattr()/permission() - we get CoW fs.  I.e. equivalent of
*BSD unionfs.  I hope to get around to that stuff around 2.5.4 or so.

