Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSLTOtQ>; Fri, 20 Dec 2002 09:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSLTOtQ>; Fri, 20 Dec 2002 09:49:16 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:21523 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262380AbSLTOtP>; Fri, 20 Dec 2002 09:49:15 -0500
Date: Fri, 20 Dec 2002 14:57:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Ben Collins <bcollins@debian.org>, lkml <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Linux 2.4.21-pre2
Message-ID: <20021220145709.A501@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Ben Collins <bcollins@debian.org>,
	lkml <linux-kernel@vger.kernel.org>,
	linux1394-devel@lists.sourceforge.net
References: <Pine.LNX.4.50L.0212181721340.18764-100000@freak.distro.conectiva> <20021220144808.GF27658@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021220144808.GF27658@fs.tum.de>; from bunk@fs.tum.de on Fri, Dec 20, 2002 at 03:48:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 03:48:08PM +0100, Adrian Bunk wrote:
> On Wed, Dec 18, 2002 at 05:22:50PM -0200, Marcelo Tosatti wrote:
> 
> >...
> > Summary of changes from v2.4.21-pre1 to v2.4.21-pre2
> > ============================================
> >...
> > Ben Collins <bcollins@debian.org>:
> >   o Linux1394 Firewire
> >...
> 
> The changes to drivers/ieee1394/Makefile broke the compilation at least 
> when compiling the ieee1394 code statically into the kernel:

Just revert the drivers/ieee1394/Makefile changes, they're bogus.

