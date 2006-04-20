Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWDTNPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWDTNPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWDTNPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:15:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46770 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750724AbWDTNPI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:15:08 -0400
Date: Thu, 20 Apr 2006 14:15:04 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: grundig <grundig@teleline.es>, Crispin Cowan <crispin@novell.com>,
       ak@suse.de, arjan@infradead.org, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060420131504.GZ27946@ftp.linux.org.uk>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <p73mzeh2o38.fsf@bragg.suse.de> <20060420011037.6b2c5891.grundig@teleline.es> <200604200138.00857.ak@suse.de> <4446E4AE.1090901@novell.com> <20060420150001.25eafba0.grundig@teleline.es> <20060420130917.GF18604@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420130917.GF18604@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 08:09:17AM -0500, Serge E. Hallyn wrote:
> Quoting grundig (grundig@teleline.es):
> > El Wed, 19 Apr 2006 18:32:30 -0700,
> > Crispin Cowan <crispin@novell.com> escribi?:
> > 
> > > Our controls on changing the name space have rather poor granularity at
> > > the moment. We hope to improve that over time, and especially if LSM
> > > evolves to permit it. This is ok, because as Andi pointed out, there are
> > > currently few applications using name spaces, so we have time to improve
> > > the granularity.
> > 
> > Wouldn't have more sense to improve it and then submit it instead of the
> > contrary? At least is the rule which AFAIK is applied to every feature 
> > going in the kernel, specially when there's an available alternative
> > which users can use meanwhile (see reiser4...)
> 
> hah, that's funny
> 
> When people do that, they are rebuked for not submitting upstream.  At
> least this way, we can have a discussion about whether the approach
> makes sense at all.

Not in such form.  If authors want the patches reviewed, the least they
can do is splitting them up in a way that would allow reading them
sequentially, damnit...
