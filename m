Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWC3SyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWC3SyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWC3SyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:54:24 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:23425 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750733AbWC3SyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:54:24 -0500
Date: Thu, 30 Mar 2006 10:55:25 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Chris Wright <chrisw@sous-sol.org>,
       David Lang <dlang@digitalinsight.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060330185525.GX15997@sorel.sous-sol.org>
References: <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com> <20060330013618.GS15997@sorel.sous-sol.org> <Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz> <20060330020445.GT15997@sorel.sous-sol.org> <20060330143224.GC6933@sergelap.austin.ibm.com> <1143734855.24555.211.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143734855.24555.211.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> FWIW, SELinux now has a notion of a type hierarchy in its policy, so the
> root admin can carve out a portion of the policy space and allow less
> privileged admins to then define sub-types that are strictly constrained
> by what was allowed to the parent type by the root admin.  This is
> handled in userspace, with the policy mediation performed by a userspace
> agent (daemon, policy management server), which then becomes the focal
> point for all policy loading.

*nod* this is exactly what I was thinking in terms of container
specifying policy.  Goes through the system/root container and gets
validated before loaded.

thanks,
-chris
