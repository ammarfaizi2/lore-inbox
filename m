Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUK3Xis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUK3Xis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbUK3Xir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:38:47 -0500
Received: from waste.org ([209.173.204.2]:45740 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262398AbUK3Xg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:36:26 -0500
Date: Tue, 30 Nov 2004 15:35:47 -0800
From: Matt Mackall <mpm@selenic.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041130233547.GX2460@waste.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> <1101828924.26071.172.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org> <1101832116.26071.236.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org> <1101837135.26071.380.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org> <20041130224851.GH8040@waste.org> <20041130225128.GA31216@infradead.org> <41ACFDAF.3040209@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ACFDAF.3040209@nortelnetworks.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 05:09:35PM -0600, Chris Friesen wrote:
> Christoph Hellwig wrote:
> 
> >>b) when include/user is deemed sufficiently populated, a flag day is
> >>declared and links from /usr/include are switched to them
> >
> >
> >there are no such links, only copies (more or less modified)

Indeed.
 
> This may be somewhat heretical, but someone has to ask...
> 
> Once include/user/foo.h is sufficiently clean and sufficiently complete, is 
> there any reason to not allow such links?

Briefly it's preferable not to need the kernel source nor a particular
version of the kernel source around to compile things. Though a
complete include/user makes building a proper kernel-headers package
to install in /usr/include pretty trivial.

-- 
Mathematics is the supreme nostalgia of our time.
