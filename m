Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbUENTmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUENTmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUENTmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:42:22 -0400
Received: from sitemail2.everyone.net ([216.200.145.36]:41180 "EHLO
	omta08.mta.everyone.net") by vger.kernel.org with ESMTP
	id S262351AbUENTmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:42:21 -0400
X-Eon-Sig: AQHOS7NApSEcGUGZQQIAAAAF,6ba807ae4e9fd6e0b49204bf65440383
Date: Fri, 14 May 2004 15:42:17 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.6.6-mm2
Message-ID: <20040514194217.GA6682@ohio.localdomain>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org> <20040513121850.B22989@build.pdx.osdl.net> <20040513123809.01398f93.akpm@osdl.org> <20040514190642.GA6333@ohio.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514190642.GA6333@ohio.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a reply to my own message.

On Fri, May 14, 2004 at 03:06:42PM -0400, Kevin O'Connor wrote:
> On Thu, May 13, 2004 at 12:38:09PM -0700, Andrew Morton wrote:
> > >  +MODULE_PARM_DESC(mask, "Mask of capability checks to ignore");
> > 
> > Is there a way to make this tunable at runtime, btw?
> 
> I thought that was what the fourth argument to module_param_named was for..
[...]
> Did I miss something?

It would significantly limit the usefulness of capabilities if root could
arbitrarily clear them.  I think I answered my own question.

Sorry for the traffic,
-Kevin
