Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWC3Sw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWC3Sw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWC3Sw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:52:26 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5248 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750717AbWC3SwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:52:25 -0500
Date: Thu, 30 Mar 2006 10:53:34 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, David Lang <dlang@digitalinsight.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060330185334.GW15997@sorel.sous-sol.org>
References: <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com> <20060330013618.GS15997@sorel.sous-sol.org> <Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz> <20060330020445.GT15997@sorel.sous-sol.org> <20060330143224.GC6933@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330143224.GC6933@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> Quoting Chris Wright (chrisw@sous-sol.org):
> > This is all fine.  The question is whether this is a policy management
> > issue or a kernel infrastructure issue.  So far, it's not clear that this
> > really necessitates kernel infrastructure changes to support container
> > aware policies to be loaded by physical host admin/owner or the virtual
> > host admin.  The place where it breaks down is if each virtual host
> > wants not only to control its own policy, but also its security model.
> 
> What do you define as 'policy', and how is it different from the
> security model?

Model, as in TE, RBAC, or something trivially simple ala Openwall type
protection.  Policy, as in rules to drive the model.

> Second, we might want container admins to insert LSMs.

I think we can agree that this way lies madness.

thanks,
-chris
