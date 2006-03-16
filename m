Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752428AbWCPRL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbWCPRL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbWCPRL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:11:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:5356 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1752428AbWCPRL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:11:26 -0500
Date: Thu, 16 Mar 2006 17:11:15 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: ray-gmail@madrabbit.org
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Christoph Hellwig <hch@infradead.org>,
       "Randy. Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-ID: <20060316171115.GV27946@ftp.linux.org.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net> <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net> <20060316163001.GA7222@infradead.org> <20060316083654.d802f3f3.rdunlap@xenotime.net> <20060316163621.GA7519@infradead.org> <Pine.LNX.4.64.0603161640230.31173@hermes-2.csi.cam.ac.uk> <20060316165035.GU27946@ftp.linux.org.uk> <2c0942db0603160905v26011d8dx1e64967b2eb4deac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0942db0603160905v26011d8dx1e64967b2eb4deac@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 09:05:05AM -0800, Ray Lee wrote:
> > And that's supposed to be an argument in favour of that crap?
> 
> So an honest, if stupid, question: How is the TRUE/FALSE stuff any
> different than the case of using a NULL when assigning a zero to a
> pointer is explicitly required to have the same effect?  They both
> seem to further the goal of better self-documenting code.

NULL is idiomatic in C.  TRUE and FALSE are definitely not.  Again,
if you want Bournegol, you know where to find it.  Grab the v7 sh
and enjoy "self-documenting" code.
