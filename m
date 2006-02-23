Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWBWUbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWBWUbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWBWUbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:31:08 -0500
Received: from kanga.kvack.org ([66.96.29.28]:45704 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932118AbWBWUbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:31:08 -0500
Date: Thu, 23 Feb 2006 15:26:06 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Greg KH <gregkh@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Gabor Gombas <gombasg@sztaki.hu>,
       "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060223202606.GB30329@kvack.org>
References: <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu> <20060222185923.GL16648@ca-server1.us.oracle.com> <20060222191832.GA14638@suse.de> <1140636588.2979.66.camel@laptopd505.fenrus.org> <20060222194024.GA15703@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222194024.GA15703@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 11:40:24AM -0800, Greg KH wrote:
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

That is a completely unreasonable position.  It is a requirement for those 
of us working on a variety of problems to be able to use new kernels on 
the "Enterprise" distributions in the market, as you have to be able to 
compare regressions and performance.  Swapping out all of userland just 
because hotplug can't get it's act together is *NOT* an option.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
