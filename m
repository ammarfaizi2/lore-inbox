Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263321AbVGAMiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263321AbVGAMiJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 08:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbVGAMiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 08:38:09 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:60122 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263321AbVGAMhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 08:37:25 -0400
Date: Fri, 1 Jul 2005 14:37:20 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
Subject: Re: FUSE merging?
Message-ID: <20050701123719.GA23795@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Andrew Morton <akpm@osdl.org>, Miklos Szeredi <miklos@szeredi.hu>,
	aia21@cam.ac.uk, arjan@infradead.org, linux-kernel@vger.kernel.org,
	frankvm@frankvm.com
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu> <20050630235059.0b7be3de.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630235059.0b7be3de.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 11:50:59PM -0700, Andrew Morton wrote:
> Speaking of which, dumb question: what does FUSE offer over simply using
> NFS protocol to talk to the userspace filesystem driver?

NFS currently does not currently engender warm feelings wrt ease of
programming and quality in general - especially under Linux sadly enough.

It is also a narrow window through which to speak to the rich set of
options, flags, attributes and features the Linux kernel offers.

I think Solaris used to implement bind mounts through loopback NFS, but that
went out of fashion as well.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
