Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759156AbWLANag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759156AbWLANag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031342AbWLANag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:30:36 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:25524 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1759156AbWLANaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:30:35 -0500
X-Originating-Ip: 74.109.98.100
Date: Fri, 1 Dec 2006 08:27:23 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: has something changed recently involving adding the git version
 string?
In-Reply-To: <Pine.LNX.4.64.0612010751510.1595@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0612010826090.1945@localhost.localdomain>
References: <Pine.LNX.4.64.0612010751510.1595@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006, Robert P. J. Day wrote:

>   has there been a change in the last few days involving whether the
> kernel option CONFIG_LOCALVERSION_AUTO appends the first part of
> $(git rev-parse HEAD) to the kernel uname?
>
>   i could have *sworn* that, only a few days ago, i could configure
> and build a new kernel with a uname release of something like
> "2.6.19-rday-ge0f1..."  now, though, all i get is "2.6.19-rday".
> and that affects the installed /lib/modules/ directory name as well.
>
>   am i just hallucinating again?
>
> rday

duh.  never mind, i just noticed the "git name-rev --tags HEAD" check
in "setlocalversion" for non-release trees.  sorry.  carry on.

rday
