Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWDYQAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWDYQAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWDYQAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:00:38 -0400
Received: from web36611.mail.mud.yahoo.com ([209.191.85.28]:36506 "HELO
	web36611.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932191AbWDYQAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:00:36 -0400
Message-ID: <20060425160036.37194.qmail@web36611.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 25 Apr 2006 09:00:36 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
To: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604250254520.15998@d.namei>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- James Morris <jmorris@namei.org> wrote:


> You are conflating the policies provided with
> SELinux systems with the 
> mechanisms of SELinux.

You have defeated me. My unabridged Webster does
not define "conflating" or even conflat, and I
guess that I'm too unhip to be up on it's modern
usage. Before I disagree with you, I'd like to
know what I've been charged with!

> One of the important features of SELinux is its
> policy flexibility, with 
> clean separation of policy and mechanism.

Except that every single time I'm meet with
SELinux developers they have emphasised how
important it is to use the Official Policies.

> SELinux provides the mechanisms 
> to control all security relevant access of processes
> to data, and accesses between processes.

Truth.

> It is up to the policy to determine how much of that
> mechanism is 
> utilized, according to desired security goals.

Yes. And a complete system policy is enormous.
500,000 rules and growing, last I heard.

> Targeted policy in fact does perform a
> usability-security tradeoff (as all 
> real security systems must do),

In Orange Book terms this was known as policy
not applying to all objects. 

> aimed at the relatively simple case of 
> protecting systems with a few internet facing
> services.  This is the 
> default policy shipped with _millions_ of Fedora and
> RHEL systems, and 
> represent, to the best of my knowledge, the first
> ever releases of general 
> purpose operating systems with MAC enabled by
> default.

Except that MAC is NOT enabled by default, it is
available by default. Only those programs and objects
identified by the policy are constrained.

> The aims and limitations of targeted policy are very
> well documented.

I'm old, so I won't say they're "very well"
documented,
but they are documented. The limitations of the
targeted
policy rarely show up in the glossy, however.

> If you wished, you could load a simpler policy which
> can offer an 
> equivalent level of protection offered by non-MAC
> schemes such as 
> AppArmor.  In fact, some work has been going on more
> generally in this 
> area in Japan during the last couple of years.

Yup. The policy description would still be large.

> Other types of users will want stricter policies, to
> meet their security 
> goals.  The SELinux mechanism is general enough to
> cater to very high 
> levels of protection and assurance.

Yes it is. It works, I admit. There are even
applications
I'd suggest it be used for.

> So, please, consider that the mechanism of SELinux
> is quite separate from 
> the types of policies which may be deployed.

Can't do that. The mechanism require large, complex
policies.

> And that arguments regarding SELinux "complexity"
> often confuse these 
> issues, as well as issues around tools and
> abstractions presented to 
> users.

The underlying mechanisms are more complex than
Bell & LePadula MAC + Biba Integrity + POSIX Caps.

I am not trying to knock SELinux (too hard) in
this discussion. I do want to point out that many
of the arguements being used against alternatives
apply to SELinux as well. I do not understand why
SELinux developers feel so threatened by alternatives.


Casey Schaufler
casey@schaufler-ca.com
