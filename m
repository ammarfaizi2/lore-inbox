Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbUKDTuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbUKDTuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUKDTkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:40:16 -0500
Received: from mra03.ex.eclipse.net.uk ([212.104.129.88]:12171 "EHLO
	mra03.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S262405AbUKDTgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:36:38 -0500
From: Ian Hastie <ianh@iahastie.clara.net>
To: Valdis.Kletnieks@vt.edu
Subject: Re: support of older compilers
Date: Thu, 4 Nov 2004 19:36:26 +0000
User-Agent: KMail/1.7.1
Cc: Adam Heath <doogie@debian.org>, Chris Wedgwood <cw@f00f.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41894779.10706@techsource.com> <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> <200411041704.iA4H4sdZ014948@turing-police.cc.vt.edu>
In-Reply-To: <200411041704.iA4H4sdZ014948@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411041936.27100.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Nov 2004 17:04, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 04 Nov 2004 10:50:38 CST, Adam Heath said:
> > I didn't deny the speed difference of older and newer compilers.
> >
> > But why is this an issue when compiling a kernel?  How often do you
> > compile your kernel?
>
> If you're working on older hardware (note the number of people on this
> list still using 500mz Pentium3 and similar), and a kernel developer, the
> difference between 2 hours to build a kernel and 4 hours to build a
> kernel matters quite a bit.

How often is it necessary to do a full rebuild of the kernel?  If the 
dependencies in the make system work properly then only the amended parts 
should be recompiled.  That'd be a much bigger time saving than just using an 
older compiler.

-- 
Ian.

EOM
