Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWBWSBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWBWSBt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWBWSBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:01:48 -0500
Received: from dvhart.com ([64.146.134.43]:51110 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932472AbWBWSBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:01:47 -0500
Message-ID: <43FDF887.40202@mbligh.org>
Date: Thu, 23 Feb 2006 10:01:43 -0800
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
References: <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu> <20060222185923.GL16648@ca-server1.us.oracle.com> <20060222191832.GA14638@suse.de> <1140636588.2979.66.camel@laptopd505.fenrus.org> <20060222194024.GA15703@suse.de> <43FDF10E.3030001@mbligh.org> <20060223175242.GA32750@suse.de>
In-Reply-To: <20060223175242.GA32750@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They are very reluctant to upgrade kernels today, for released versions
> of the distro, and so they backport kernel fixes and security updates to
> that older kernel, just like all of the packages in a distro.  That's
> they way they work.
> 
> But they work together with mainline as they need it for their _next_
> release that happens again in 6 months or so, with the updated kernel
> and everything else.

I don't think that's universally true at all, either from my own 
observations, or that of others I have talked to.

What I see is people operating in their own silos, and being terrified
to upgrade because they have no idea what random breakage will have
occured in mainline. When they get into that mode, the not only don't
suck new kernels down, they don't push their own changes up.

That's not healthy, and whatever we can do to encourage them to play
with the rest of the world more nicely would be healthy, I think.

M.
