Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVLCW1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVLCW1h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVLCW1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:27:37 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:10926 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S1751298AbVLCW1g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:27:36 -0500
Date: Sat, 3 Dec 2005 23:27:31 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203222731.GC25722@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <4391CEC7.30905@unsolicited.net> <1133630012.6724.7.camel@localhost.localdomain> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de> <4391E52D.6020702@unsolicited.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <4391E52D.6020702@unsolicited.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Dec 2005, David Ranson wrote:

> Adrian Bunk wrote:
> 
> >- support for ipfwadm and ipchains was removed during 2.6
> >
> >
> Surely this one had loads of notice though? I was using iptables with
> 2.4 kernels.

So was I. And now what? ipfwadm and ipchains should have been removed
from 2.6.0 if 2.6.0 was not to support these. That opportunity was
missed, the removal wasn't made up for in 2.6.1, so the stuff has to
stick until 2.8.0.

> >- devfs support was removed during 2.6
>
> Did this affect many 'real' users?

This doesn't matter. A kernel that calls itself stable CAN NOT remove
features unless they had been critically broken from the beginning. And
this level of breakage is a moot point, so removal is not justified.

> >- removal of kernel support for pcmcia-cs is pending
> >- ip{,6}_queue removal is pending
> >- removal of the RAW driver is pending

> I don't use any of these. I guess pcmcia-cs may be disruptive for laptop
> users.

Who cares what you or I use? It's a commonly acknowledged policy that
"stable" releases do not remove features that are good enough for some.
Linux 2.6 is not "stable" in this regard.

-- 
Matthias Andree
