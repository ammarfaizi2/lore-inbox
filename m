Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWDZL2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWDZL2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 07:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDZL2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 07:28:14 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:15062 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932398AbWDZL2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 07:28:13 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: James Morris <jmorris@namei.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060426035615.18418.qmail@web36605.mail.mud.yahoo.com>
References: <20060426035615.18418.qmail@web36605.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 26 Apr 2006 07:32:40 -0400
Message-Id: <1146051160.28745.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 20:56 -0700, Casey Schaufler wrote:
> 
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > On Tue, 2006-04-25 at 09:00 -0700, Casey Schaufler
> > wrote:
> > > The underlying mechanisms are more complex than
> > > Bell & LePadula MAC + Biba Integrity + POSIX Caps.
> > 
> > Until one also considers the set of trusted subjects
> > in systems that
> > rely on such models.
> 
> How so? It's pretty much the same set of subjects
> as you'd find in SELinux.
> 
> > That's the point.  Those subjects are free to
> > violate the "simple" models, at which point any
> > analysis of the
> > effective policy of the system has to include them
> > as well.
> 
> Yup, and you're going to have to provide analysis
> of the subjects under SELinux as well. No way are
> you going to convince anyone that a half-million
> lines of policy definition are 100% error free.
> 
> > SELinux/TE
> > just makes the real situation explicit in the
> > policy, and enables you to
> > tailor the policy to the real needs of applications
> > while still being
> > able to analyze the result.
> 
> This is what I don't get. How can you claim that
> you can analyse a policy definition that big?
> Further, I remember arguments to the effect of
> a programmer being able to knock off the policy
> for a program in 10 minutes. Having written and
> analysed as many MLS systems as anyone on the
> planet you'll excuse my scepicism. And poor speling.

Perhaps we aren't communicating very well.  There are already tools like
apol and slat that perform information flow analysis of SELinux policies
and that can be used to check properties.  

-- 
Stephen Smalley
National Security Agency

