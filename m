Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUIDMhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUIDMhL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUIDMhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:37:11 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:23512 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267815AbUIDMg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:36:58 -0400
Date: Sat, 4 Sep 2004 13:36:56 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <1094301014.2801.10.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0409041333230.25475@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> 
 <Pine.LNX.4.58.0409040145240.25475@skynet>  <20040904102914.B13149@infradead.org>
  <41398EBD.2040900@tungstengraphics.com>  <20040904104834.B13362@infradead.org>
  <413997A7.9060406@tungstengraphics.com>  <20040904112535.A13750@infradead.org>
  <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com>
  <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com>
  <4139B03A.6040706@tungstengraphics.com>  <Pine.LNX.4.58.0409041311020.25475@skynet>
 <1094301014.2801.10.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > properly with the core...
>
> or they just ship their own matching core .c file as well....
>
> Lets face it, for the core there are 2 things that are entirely at
> conflicts: small interface and core being useful.
> I rather go for the useful side myself.

It's still useful, it just is built into the drivers as a library rather
than the kernel, and the actual "core" is just a major number sharing
scheme, again the only advantage of building the library functions into
the kernel or as a separate module are a small memory saving on a rare use
case, hardly an astounding reason,

New functions added to the library can be made available to new drivers,
and vendors can ship their own set of library sources and not use
the kernels ones..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

