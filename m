Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWDUSDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWDUSDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWDUSDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:03:04 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:2536 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932157AbWDUSDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:03:01 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@sous-sol.org>
Cc: James Morris <jmorris@namei.org>, Arjan van de Ven <arjan@infradead.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060421173008.GB3061@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <1145470463.3085.86.camel@laptopd505.fenrus.org>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <1145522524.3023.12.camel@laptopd505.fenrus.org>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 14:07:33 -0400
Message-Id: <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 10:30 -0700, Chris Wright wrote:
> * Stephen Smalley (sds@tycho.nsa.gov) wrote:
> > Difficult to evaluate, when the answer whenever a flaw is pointed out is
> > "that's not in our threat model."  Easy enough to have a protection
> > model match the threat model when the threat model is highly limited
> > (and never really documented anywhere, particularly in a way that might
> > warn its users of its limitations).
> 
> I know, there's two questions.  Whether the protection model is valid,
> and whether the threat model is worth considering.  So far, I've not
> seen anything that's compelling enough to show AppArmor fundamentally
> broken.  Ugly and inefficient, yes...broken, not yet.

Access control of any form requires unambiguous identification of
subjects and objects in the system.   Paths don't achieve such
identification.  Is that broken enough?  If not, what is?  What
qualifies as broken?

-- 
Stephen Smalley
National Security Agency

