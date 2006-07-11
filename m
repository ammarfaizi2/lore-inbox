Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWGKOsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWGKOsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWGKOsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:48:17 -0400
Received: from smtp.reflexsecurity.com ([72.54.64.74]:11227 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id S1750917AbWGKOsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:48:17 -0400
Date: Tue, 11 Jul 2006 10:47:44 -0400
From: Jason Lunz <lunz@falooley.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060711144743.GA24187@knob.reflex>
References: <20060627133321.GB3019@elf.ucw.cz> <200607100706.45789.ncunningham@linuxmail.org> <e8sj71$nad$1@sea.gmane.org> <200607101620.34408.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607101620.34408.ncunningham@linuxmail.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 04:20:30PM +1000, Nigel Cunningham wrote:
> The switch to using the swsusp lowlevel code was a bit bumpy, and I do admit 
> that I broke swsusp from time to time, but these are the exceptions (as you 
> say), and the general design is such that they should be coexist. I'll freely 
> admit that I don't regularly test swsusp, but I'm also not reguarly changing 
> things that should break it.

I would suggest testing swsusp before each suspend2 release. It's not
difficult at all to maintain a system that can suspend to disk using
either method, especially if you use something like Bernard's hibernate
scripts.

I would say that's especially important if you're posting the patches
for inclusion in mainline. It's simply not acceptible to merge patches
that break working in-kernel setups.

> Did you report them to the list? I try to be responsive (although, again, I 
> don't always succeed to the extent that I'd like.

Unfortunately, no. Because of the intermittency of the crashes, I was
usually on the road or in the middle of something else when a crash
happened, so I never captured any of the backtraces.

Jason
