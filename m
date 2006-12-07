Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032567AbWLGRBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032567AbWLGRBK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162046AbWLGRBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:01:09 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:2818 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032568AbWLGRBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:01:07 -0500
Date: Thu, 7 Dec 2006 18:01:04 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] PCI MMConfig: Share what's shareable.
Message-ID: <20061207170103.GB50797@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Muli Ben-Yehuda <muli@il.ibm.com>, Andi Kleen <ak@suse.de>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061207144952.GA45089@dspnet.fr.eu.org> <20061207150023.GH28515@rhun.haifa.ibm.com> <20061207151941.GA45592@dspnet.fr.eu.org> <20061207153506.GJ28515@rhun.haifa.ibm.com> <20061207155336.GA50797@dspnet.fr.eu.org> <20061207160317.GL28515@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207160317.GL28515@rhun.haifa.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 06:03:17PM +0200, Muli Ben-Yehuda wrote:
> On Thu, Dec 07, 2006 at 04:53:36PM +0100, Olivier Galibert wrote:
> 
> > # git grep '//' -- '*.c' |fgrep -v 'http://' |wc -l
> > 14333
> > 
> > You lost that war ages ago.  Come join us in this millenia,
> > line-comments exist officially in C since 1999, and were supported
> > way before that.
> 
> If I was bored, I might've counted how many /* */ style comments we
> had in the source,

426K or so.

> then used it to construct an elaborate argument why C++-style
> comments are evil and Conformance is Goodness, but I'm not, so I
> won't.

I've yet to see an actual technical argument against them.  I find
them more readable by making it perfectly obvious what their
application range is, contrary to /* where you need to find the
closing */.  But that's just me.

  OG.
