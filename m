Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTIBUaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTIBUaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:30:04 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:51082 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264097AbTIBUaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:30:00 -0400
Date: Tue, 2 Sep 2003 21:29:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030902202947.GA16171@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829154101.GB16319@work.bitmover.com> <20030901054413.GF748@mail.jlokier.co.uk> <20030901144304.GA1327@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901144304.GA1327@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> Results for Alpha, IA64, MIPS, ARM, PARISC, PPC, MIPSEL, X86, SPARC, s390
> on Linux and hpux/parisc, {freebsd, netbsd, openbsd}/x86, sco/x86, 
> solaris/sparc, solaris/x86, irix/mips, osx/ppc, aix/ppc, tru64/alpha.

It's interesting to see all the free unixes, Solaris and SCO have no
trouble mapping files.  But AIX, HPUX and whatever environment you
have on Windows XP couldn't even do the mmaps.

Could you be able to try the aix/ppc, hpux/parisc and Windows XP (or
any Windows) tests again, but this time try each of these:

	1. Compile with -DHAVE_SHM_OPEN
	2. Compile with -DHAVE_SYSV_SHM

Thanks again,
-- Jamie
