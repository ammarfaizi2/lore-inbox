Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWEBOee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWEBOee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWEBOee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:34:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43213 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964844AbWEBOed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:34:33 -0400
Date: Tue, 2 May 2006 15:34:30 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Avi Kivity <avi@argo.co.il>
Cc: Willy Tarreau <willy@w.ods.org>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
Message-ID: <20060502143430.GW27946@ftp.linux.org.uk>
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <20060502133416.GT27946@ftp.linux.org.uk> <4457668F.8080605@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4457668F.8080605@argo.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 05:02:55PM +0300, Avi Kivity wrote:
> Hey, I agree 100%, except for the last 6 words :) C++ is the very worst 
> language I know in terms of badly thought out features, internal 
> inconsistencies, ways to shoot one's feet off, and general ugliness. It 
> will require _very_ tight control to avoid parts of the kernel going off 
> in mutually incompatible directions.
> 
> But I think that the control is there; and if C++ is introduced slowly, 
> one feature at a time, it can be kept sane. And I think there is 
> definitely a payoff to be won out of a switch.

You are far too optimistic.  In the best case it'll end up with higher
artificial entry barrier for contributors.  In the worst (and much more
realistic) the crap will leak all over the tree in addition to the
already present classes of bugs.

"Everyone has his pet subset/extension" is a killer for anything that isn't
done by 5-6 people, or, at least reviewed by 5-6 people who really can
read through _all_ incoming code.  For something like Linux kernel...
forget it.  It's far outside of the area where that would work.
