Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWIAOXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWIAOXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 10:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWIAOXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 10:23:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35844 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750812AbWIAOXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 10:23:32 -0400
Date: Thu, 1 Jan 1970 00:16:58 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <w@1wt.eu>, Ernie Petrides <petrides@redhat.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: printk()s of user-supplied strings
Message-ID: <19700101001658.GA4066@ucw.cz>
References: <20060822030755.GB830@openwall.com> <200608222023.k7MKNHpH018036@pasta.boston.redhat.com> <20060824164425.GA17692@openwall.com> <20060824164633.GA21807@1wt.eu> <20060826022955.GB21620@openwall.com> <20060826082236.GA29736@1wt.eu> <20060826231314.GA24109@openwall.com> <20060827200440.GA229@1wt.eu> <20060828015224.GA27199@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828015224.GA27199@openwall.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Another idea I had was to add a new format specifier to vsnprintf()
> > to explicitly escape the string (eg: "%S"). But there are so many
> > users of printk() to fix then that I'm not sure we would find them
> > all. However, it would be the real fix and not a hack because what
> > we're trying to do is to enforce controls on some data type, which
> > is exactly the point of this solution.
> 
> Yes, I had this thought, too.  This would be the cleanest solution, but
> I'm afraid that it will fail in practice.  People will continue

Please go for the cleanest solution. Anything else is not mergeable.

-- 
Thanks for all the (sleeping) penguins.
