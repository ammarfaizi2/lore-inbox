Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbUBTKNP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 05:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUBTKNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 05:13:15 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:2091 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261155AbUBTKM7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 05:12:59 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200402201013.i1KAD1HC008349@green.mif.pg.gda.pl>
Subject: Re: mremap patches for 2.4 and 2.2?
To: vherva@viasys.com
Date: Fri, 20 Feb 2004 11:13:01 +0100 (CET)
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <200402200946.i1K9k2OH015422@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Feb 20, 2004 10:46:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Feb 19, 2004 at 09:56:36AM -0800, you [Chris Wright] wrote:
> > * Nur Hussein (obiwan@slackware.org.my) wrote:
> > > However, I am still intrigued by this fix:
> > > 
> > > http://linux.bkbits.net:8080/linux-2.4/diffs/mm/mremap.c@1.7?nav=cset@1.1136.94.4
> > > 
> > > It does not seem to be in 2.6.3. I can only assume 2.6.x does not
> > > require it? The Changeset says it is to prevent a potential exploit by
> > > the malicious use of mremap().
> > 
> > It's fixed in 2.6 as well.
> > 
> > http://linux.bkbits.net:8080/linux-2.5/diffs/mm/mremap.c@1.35?nav=index.html|src/|src/mm|hist/mm/mremap.c
> 
> Are these the sole patches one should apply for this vulnerability if
> patching an older 2.4 or 2.6?
> 
> Is there a patch for 2.2 somewhere?

linux-2.2-mremap-munmap.patch

You can get it from cvs.pld-linux.org CVS or extract from:
ftp://ftp.pld-linux.org/dists/ra/updates/security/SRPMS/kernel-2.2.25-4.src.rpm

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
