Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVAYN4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVAYN4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVAYN4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:56:02 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40211
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261948AbVAYNzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:55:35 -0500
Date: Tue, 25 Jan 2005 14:55:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: memory leak in 2.6.11-rc2
Message-ID: <20050125135530.GQ7587@dualathlon.random>
References: <20050120020124.110155000@suse.de> <16884.8352.76012.779869@samba.org> <200501232358.09926.agruen@suse.de> <200501240032.17236.agruen@suse.de> <16884.56071.773949.280386@samba.org> <16885.47804.68041.144011@samba.org> <20050125034546.GF13394@redhat.com> <20050125125135.GO7587@dualathlon.random> <1106659863.9607.9.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106659863.9607.9.camel@winden.suse.de>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 02:31:03PM +0100, Andreas Gruenbacher wrote:
> On Tue, 2005-01-25 at 13:51, Andrea Arcangeli wrote:
> > If somebody could fix the kernel CVS I could have a look at the
> > interesting changesets between 2.6.11-rc1-bk8 and 2.6.11-rc2.
> 
> What's not okay?

I already prepared a separated deatiled bugreport. I'm reproducing one
last time before sending it, after a "su - nobody" to be sure it's not a
local problem in my environment that might have changed, but I'm 99%
sure it'll reproduce just fine in a fresh account too.

Are you using cvsps at all?
