Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVCOVSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVCOVSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 16:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVCOVSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 16:18:22 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:2718 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261837AbVCOVST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 16:18:19 -0500
Message-ID: <42375119.3000506@lsrfire.ath.cx>
Date: Tue, 15 Mar 2005 22:18:17 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
Cc: Bodo Eggert <7eggert@gmx.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com
Subject: Re: [PATCH][RFC] Make /proc/<pid> chmod'able
References: <1110771251.1967.84.camel@cube>	 <42355C78.1020307@lsrfire.ath.cx> <1110816803.1949.177.camel@cube>	 <Pine.LNX.4.58.0503142333480.6357@be1.lrz> <1110854667.7893.203.camel@cube>
In-Reply-To: <1110854667.7893.203.camel@cube>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> This really isn't about security. Privacy may be undesirable.

I agree, privacy is not security.  My patch tries to enhance privacy 
without giving up security.

You think losing the social pressure that comes with mutual surveillance 
results in loss of security, I don't.  Now I think Linux should support 
both ways and those writing security policies should make the decision.

> With privacy comes anti-social behavior. Supposing that the
> users do get privacy, perhaps because the have paid for it:
> 
> Xen, UML, VM, VMware, separate computers
> 
> Going with separate computers is best. Don't forget to use
> network traffic control to keep users from being able to
> detect the network activity of other users.

That would work, but it requires a *lot* of administrative and computing 
overhead.  Note that "separate computers" alone is not sufficient 
because most places with more than a few machines have some kind of 
single signon and run SSH or similar.

[ps, w, top]
> They work like they do with a rootkit installed.
> Traditional behavior has been broken.

That's one way to put it; you could also say those tools now provide 
enhanced privacy. ;)

I also think things have changed in the last few years.  Since the 
advent of special data processing laws privacy is taken more serious. 
Privacy certainly was no real concern when UNIX was young.  I also guess 
it's a cultural thing, its importance being different from country to 
country.

It's easily visible in the style of public toilets: in some contries you 
have one big room with no walls in between where all men or women 
merrily shit together, in other countries (like mine) every person can 
lock himself into a private closet.  Both ways work, there's nothing too 
special about using a toilet, but I'm simply used to the privacy 
provided by those thin walls.  I assure you, I don't do anything evil in 
there. :]
