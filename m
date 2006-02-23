Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWBWR3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWBWR3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWBWR3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:29:53 -0500
Received: from dvhart.com ([64.146.134.43]:45478 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751756AbWBWR3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:29:52 -0500
Message-ID: <43FDF10E.3030001@mbligh.org>
Date: Thu, 23 Feb 2006 09:29:50 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Gabor Gombas <gombasg@sztaki.hu>,
       "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
References: <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu> <20060222185923.GL16648@ca-server1.us.oracle.com> <20060222191832.GA14638@suse.de> <1140636588.2979.66.camel@laptopd505.fenrus.org> <20060222194024.GA15703@suse.de>
In-Reply-To: <20060222194024.GA15703@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I totally agree.  Distros are changing into two different groups these
> days:
> 	- everything tied together and intregrated nicely for a specific
> 	  kernel version, userspace tool versions, etc.
> 	- flexible and works with multiple kernel versions, different
> 	  userspace tools, etc.
> 
> Distros in the first category are the "enterprise" releases (RHEL, SLES,
> etc.), as well as some consumer oriented distros (SuSE, Ubuntu, Fedora
> possibly.)
> 
> More flexible distros that handle different kernel versions are Gentoo,
> Debian, and probably Fedora.
> 
> And this is a natural progression as people try to provide a more
> complete "solution" for users.
> 
> When people to complain that they can't run a "kernel-of-the-day" on
> their "enterprise" distro, they are not realizing that that distro was
> just not developed to support that kind of thing at all.
> 
> So, in short, if you are going to do kernel development, pick a distro
> that handles different kernel versions.  Likewise, if you are doing
> userspace development (X.org, HAL, KDE, Gnome, etc.) you pick a distro
> that allows you to change that level of the stack.

That sort of thing is going to make distros incredibly reluctant to 
update kernels, which just encourages them to operate inside their own
fiefdoms, rather than working together with mainline, which is what we
want.

Moreover, its' not just the big distros. It's every corporation with a
product based around Linux, which are far more numerous and smaller
operations. We *have* to encourage these people to work with us, else
we end up not getting bug fixes back upstream from them etc.

That means giving them stable, consistent userspace<->kernel APIs.

M.
