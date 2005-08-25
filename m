Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVHYQWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVHYQWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVHYQWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:22:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7582 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932264AbVHYQWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:22:35 -0400
Date: Thu, 25 Aug 2005 09:21:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: serue@us.ibm.com, Chris Wright <chrisw@osdl.org>,
       linux-security-module@wirex.com, Greg Kroah <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH 5/5] Remove unnecesary capability hooks in rootplug.
Message-ID: <20050825162101.GU7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain> <20050825012150.490797000@localhost.localdomain> <20050825143807.GA8590@sergelap.austin.ibm.com> <1124982836.3873.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124982836.3873.78.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Thu, 2005-08-25 at 09:38 -0500, serue@us.ibm.com wrote:
> > Ok, with the attached patch SELinux seems to work correctly.  You'll
> > probably want to make it a little prettier  :)  Note I have NOT ran the
> > ltp tests for correctness.  I'll do some performance runs, though
> > unfortunately can't do so on ppc right now.
> 
> Note that the selinux tests there _only_ test the SELinux checking.  So
> if these changes interfere with proper stacking of SELinux with
> capabilities, that won't show up there.  

Sorry, I'm not parsing that?
-chris
