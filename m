Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVHYFcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVHYFcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVHYFcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:32:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964847AbVHYFcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:32:23 -0400
Date: Wed, 24 Aug 2005 22:32:08 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@namei.org>
Cc: Chris Wright <chrisw@osdl.org>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH 0/5] LSM hook updates
Message-ID: <20050825053208.GS7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain> <Pine.LNX.4.63.0508250038450.13875@excalibur.intercode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508250038450.13875@excalibur.intercode>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@namei.org) wrote:
> On Wed, 24 Aug 2005, Chris Wright wrote:
> 
> > This is based on Kurt's original work.  The net effect is that
> > LSM hooks are called conditionally, and in all cases capabilities
> > provide the defaults.  I've done some basic performance testing, and
> > found nothing surprising.
> 
> Do you mean nothing noticable?

I did only microbenchmarking, which was as much as double digit percentage
faster (on P4), nothing was slower.

> >  I'm interested to see numbers from others
> > before I push this up.  These are against Linus' current git tree (they
> > will clash with the -mm tree).
> 
> Are there any numbers for popular architectures like i386 and x86_64?

I'll have some numbers tomorrow.  If you'd like to run SELinux that'd
be quite useful.

thanks,
-chris
