Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVEMRNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVEMRNU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVEMRNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:13:20 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:34326 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S262437AbVEMRNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:13:17 -0400
Date: Fri, 13 May 2005 10:13:00 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Daniel Jacobowitz <dan@debian.org>, "Barry K. Nathan" <barryn@pobox.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513171300.GA30909@hexapodia.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050513124735.GA7436@ip68-225-251-162.oc.oc.cox.net> <4284B55C.7010202@pobox.com> <20050513142336.GA6174@nevyn.them.org> <4284BA90.5080508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4284BA90.5080508@pobox.com>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 10:32:48AM -0400, Jeff Garzik wrote:
> Daniel Jacobowitz wrote:
> >  http://www.daemonology.net/hyperthreading-considered-harmful/
> 
> Already read it.  This link provides no more information than either of 
> the above links provide.

He's posted his paper now.

http://www.daemonology.net/papers/htt.pdf

It's a side channel timing attack on data-dependent computation through
the L1 and L2 caches.  Nice work.  In-the-wild exploitation is
difficult, though; your timing gets screwed up if you get scheduled away
from your victim, and you don't even know, because you can't tell where
you were scheduled, so on any reasonably busy multiuser system it's not
clear that the attack is practical.

-andy
