Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWDZD4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWDZD4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 23:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWDZD4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 23:56:20 -0400
Received: from web36605.mail.mud.yahoo.com ([209.191.85.22]:57721 "HELO
	web36605.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932351AbWDZD4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 23:56:19 -0400
Message-ID: <20060426035615.18418.qmail@web36605.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 25 Apr 2006 20:56:15 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <1145986194.21399.80.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2006-04-25 at 09:00 -0700, Casey Schaufler
> wrote:
> > The underlying mechanisms are more complex than
> > Bell & LePadula MAC + Biba Integrity + POSIX Caps.
> 
> Until one also considers the set of trusted subjects
> in systems that
> rely on such models.

How so? It's pretty much the same set of subjects
as you'd find in SELinux.

> That's the point.  Those subjects are free to
> violate the "simple" models, at which point any
> analysis of the
> effective policy of the system has to include them
> as well.

Yup, and you're going to have to provide analysis
of the subjects under SELinux as well. No way are
you going to convince anyone that a half-million
lines of policy definition are 100% error free.

> SELinux/TE
> just makes the real situation explicit in the
> policy, and enables you to
> tailor the policy to the real needs of applications
> while still being
> able to analyze the result.

This is what I don't get. How can you claim that
you can analyse a policy definition that big?
Further, I remember arguments to the effect of
a programmer being able to knock off the policy
for a program in 10 minutes. Having written and
analysed as many MLS systems as anyone on the
planet you'll excuse my scepicism. And poor speling.



Casey Schaufler
casey@schaufler-ca.com
