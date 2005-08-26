Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbVHZSId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbVHZSId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbVHZSId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:08:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965159AbVHZSIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:08:31 -0400
Date: Fri, 26 Aug 2005 11:08:23 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Tony Jones <tonyj@suse.de>, Chris Wright <chrisw@osdl.org>,
       Kurt Garloff <garloff@suse.de>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Rework stubs in security.h
Message-ID: <20050826180823.GQ7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain> <20050825012148.690615000@localhost.localdomain> <20050826173151.GA1350@immunix.com> <1125079256.8692.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125079256.8692.65.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> That one isn't so much an issue as the xattr ones and vm_enough_memory
> case.  But more generally, if you think about moving toward a place
> where one can grant privileges to processes based solely on their
> role/domain, you'll need the same ability for capable and other hooks
> too.  Naturally, that can't be done safely without a lot more work on
> userspace and policy, but it is a long term goal.

Right, you've mentioned that before, thanks for bringing that up.
