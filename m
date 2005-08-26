Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbVHZRuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbVHZRuG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVHZRuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:50:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965145AbVHZRuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:50:05 -0400
Date: Fri, 26 Aug 2005 10:49:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: serue@us.ibm.com
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Kurt Garloff <garloff@suse.de>, Stephen Smalley <sds@epoch.ncsc.mil>,
       linux-security-module@wirex.com
Subject: Re: [PATCH 0/5] LSM hook updates
Message-ID: <20050826174956.GO7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain> <Pine.LNX.4.63.0508250038450.13875@excalibur.intercode> <20050825053208.GS7762@shell0.pdx.osdl.net> <20050825191548.GY7762@shell0.pdx.osdl.net> <20050826092306.GA429@sergelap.austin.ibm.com> <20050826164139.GK7762@shell0.pdx.osdl.net> <20050826173508.GA11489@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826173508.GA11489@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* serue@us.ibm.com (serue@us.ibm.com) wrote:
> Quoting Chris Wright (chrisw@osdl.org):
> > > A little surprising: kernbench is improved, but dbench and tbench
> > > are worse - though within the 95% CI.
> > 
> > It is interesting.  Would be good to see what happens with the cap_ bits
> > used in SELinux instead of secondary callout.
> 
> Here are the new numbers next to the originals.  'patchedv2' is
> obviously with your new patch.  Kernbench keeps getting faster :)

Thanks again.  Hmm, tbench fell a bit more, reaim is sort of all over
the place.  Do you have a harness for this?  I can run same on hardware
here (in particular I'm interested to do P4 and ia64).

thanks,
-chris
