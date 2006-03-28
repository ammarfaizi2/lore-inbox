Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWC1UO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWC1UO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWC1UO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:14:28 -0500
Received: from smtpout.mac.com ([17.250.248.97]:7157 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932134AbWC1UO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:14:28 -0500
In-Reply-To: <200603282204.53493.mmazur@kernel.pl>
References: <200603141619.36609.mmazur@kernel.pl> <442783E3.3050808@argo.co.il> <200603271448.56645.rob@landley.net> <200603282204.53493.mmazur@kernel.pl>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <082D0EAB-54E0-4BF4-AEAB-7BDE82E30AD8@mac.com>
Cc: Rob Landley <rob@landley.net>, Avi Kivity <avi@argo.co.il>,
       Arjan van de Ven <arjan@infradead.org>, nix@esperi.org.uk,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Tue, 28 Mar 2006 15:13:52 -0500
To: Mariusz Mazur <mmazur@kernel.pl>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 28, 2006, at 15:04:53, Mariusz Mazur wrote:
> On Monday 27 March 2006 21:48, Rob Landley wrote:
>> Either way, it's not sounding like something I can grab and build  
>> uClibc systems with any time soon, the way I could use Mazur's  
>> headers to build uClibc.  I'll probably wind up using the gentoo  
>> headers when the 2.6.14 version ships.
>
> That's the trouble. While I have nothing against someone (as in --  
> not me :) doing all that abi separation, it's not something I can  
> use straight away. Hell, I don't even get where in all of it I'd  
> end up with something I could use (granted, I haven't looked into  
> the thread too closely). Not to mention, that I suspect, that if  
> there were enough people to do it, it would have gotten done two  
> years ago.
>
> So unless anybody's got a better idea, I'll try releasing some  
> initial version of that llh-ng thingie rather soonish and see how  
> that'll work out. Anybody with me on that? :)

I agree with this approach.  I don't think the llh-ng method will be  
maintainable in the long-term, which is why I'm doing the KABI  
patches, but I think that in the short term that's the fastest way to  
get a working set of headers against which to build glibc.

Cheers,
Kyle Moffett
