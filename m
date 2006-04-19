Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWDSSaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWDSSaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDSSaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:30:06 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:41648 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751046AbWDSSaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:30:03 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Emily Ratliff <ejratl@gmail.com>
Cc: David Safford <safford@watson.ibm.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, James Morris <jmorris@namei.org>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <2e00cdfd0604191057h5d663319xab6ee62ca58fbe28@mail.gmail.com>
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com>
	 <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417192634.GB18990@sergelap.austin.ibm.com>
	 <Pine.LNX.4.64.0604171528340.17923@d.namei>
	 <20060417194759.GD18990@sergelap.austin.ibm.com>
	 <1145304146.8542.251.camel@moss-spartans.epoch.ncsc.mil>
	 <1145458322.2377.12.camel@localhost.localdomain>
	 <1145460417.24289.116.camel@moss-spartans.epoch.ncsc.mil>
	 <2e00cdfd0604191057h5d663319xab6ee62ca58fbe28@mail.gmail.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 19 Apr 2006 14:33:56 -0400
Message-Id: <1145471636.24289.236.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 12:57 -0500, Emily Ratliff wrote:
> On 4/19/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > BTW, since you point to LOMAC as evidence, can you point to an actual
> > user community that uses LOMAC?
> EVM & SLIM are part of IBM's internal supported Linux desktop, so
> there are quite a few users.

Um, ok.  Not sure what that means in practice, but good to know you have
actual users.

> And Tim Fraser's and Dave Safford's responses are noted in
> http://marc.theaimsgroup.com/?l=linux-security-module&m=113323166505015&w=2
> http://marc.theaimsgroup.com/?l=linux-security-module&m=113337110408758&w=2
> http://marc.theaimsgroup.com/?l=linux-security-module&m=113234278611701&w=2

But AFAICS they didn't respond to my actual points, whereas I responded
to their points.  In the end, their argument seemed to degenerate to
"SLIM should be accepted because it differs from SELinux" or "embrace
diversity for diversity's sake."  Not entirely compelling.

> > If such models can demonstrate their viability, then you can ultimately
> > submit a patch to extend SELinux/Flask to support them - I have no
> > problem with that (again, if they can be shown to be viable and
> > implementation is correct).
> Dave has an existing implementation with a user base of a formally
> proven security model. He is addressing implementation concerns and
> continuing to try to get SLIM accepted. Why should he be required to
> extend SELinux?

Well, I haven't seen any new code submitted since last Nov, and the code
at that time was badly broken to the point that it seemed to require a
re-design, and none of the modules at the time appeared to justify LSM
or the stacker; if anything, they were a warning that the stacker and
LSM lend themselves to misuse, confusion, and broken code.

I'm sure we'd all be glad to see new patches.  But the issues that were
raised during the original discussion still need to be addressed.

-- 
Stephen Smalley
National Security Agency

