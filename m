Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264189AbUDUAlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbUDUAlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbUDUAlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:41:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:21175 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264189AbUDUAlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:41:49 -0400
Date: Tue, 20 Apr 2004 17:41:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zack Brown <zbrown@tumblerings.org>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: matching "Cset exclude" changelog entries to the changelog entries they revert.
Message-ID: <20040420174147.G21045@build.pdx.osdl.net>
References: <20040421001236.GA16901@tumblerings.org> <20040420172622.K22989@build.pdx.osdl.net> <20040421003820.GB16901@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040421003820.GB16901@tumblerings.org>; from zbrown@tumblerings.org on Tue, Apr 20, 2004 at 05:38:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zack Brown (zbrown@tumblerings.org) wrote:
> On Tue, Apr 20, 2004 at 05:26:22PM -0700, Chris Wright wrote:
> > * Zack Brown (zbrown@tumblerings.org) wrote:
> > > for instance, "Cset exclude: davej@suse.de|ChangeSet|20020403195622" is in
> > > 2.5.8-pre2, as the full text of the changelog entry.
> > 
> > bk prs -r"davej@suse.de|ChangeSet|20020403195622" -hnd:REV: ChangeSet
> > 
> > That will give you the rev from that key in the Cset exclude message.
> 
> Will this give me the text of the changelog entry being reverted? That's
> what I need to find.

This would give you a revision nubmer like: 1.369.104.61.  So you could
then do bk changes -r1.369.104.61 to see the changelog entry.

> Also, I'm not allowed to license BK. Is there some other way?

Ugh.  I can't think of any, unless the bk->cvs gateway puts the
ChangeSet Key (the davej@suse.de|ChangeSet|20020403195622 bit) in the
cvs changelog message somewhere.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
