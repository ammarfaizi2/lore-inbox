Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbUDFFL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 01:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUDFFL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 01:11:58 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:22554 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S263621AbUDFFLz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 01:11:55 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200404060511.i365Bpie022092@green.mif.pg.gda.pl>
Subject: Re: PTS alocation problem with 2.6.4/2.6.5
To: akpm@osdl.org (Andrew Morton)
Date: Tue, 6 Apr 2004 07:11:51 +0200 (CEST)
Cc: ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
       linux-kernel@vger.kernel.org
In-Reply-To: <20040405165957.5f8ab8dc.akpm@osdl.org> from "Andrew Morton" at Apr 05, 2004 04:59:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl> wrote:
> >
> > I noticed serious problem with PTS alocation on kernels 2.6.4 and 2.6.5:
> > It seems that once alocated /dev/pts entries are never reused, leading to
> > pty alocation errors. The testing system is fully compiled with kernel 2.2.x
> > headers (including glibc), but informations from my coleagues using systems
> > compiled on 2.4/2.6 headers seems to behave similarily.
> > The testcase and used kernel configuration are shown below.
> > Kernel 2.6.3 does not have this problem.
> > Is it bug or feature (and I am doing sth wrong) ?
> 
> You need a glibc upgrade - we broke things for really old glibc's.  We're
> (slowly) working on fixing it up.

Hmmm, which version is enough ?

I use glibc-2.2.5, but people using glibc-2.3.3 snapshot, dated 20040101
also have the same problem...

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
