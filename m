Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWDYRZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWDYRZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWDYRZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:25:28 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:22936 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751566AbWDYRZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:25:27 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: James Morris <jmorris@namei.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060425160036.37194.qmail@web36611.mail.mud.yahoo.com>
References: <20060425160036.37194.qmail@web36611.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 13:29:54 -0400
Message-Id: <1145986194.21399.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 09:00 -0700, Casey Schaufler wrote:
> The underlying mechanisms are more complex than
> Bell & LePadula MAC + Biba Integrity + POSIX Caps.

Until one also considers the set of trusted subjects in systems that
rely on such models.  That's the point.  Those subjects are free to
violate the "simple" models, at which point any analysis of the
effective policy of the system has to include them as well.  SELinux/TE
just makes the real situation explicit in the policy, and enables you to
tailor the policy to the real needs of applications while still being
able to analyze the result.

> I am not trying to knock SELinux (too hard) in
> this discussion. I do want to point out that many
> of the arguements being used against alternatives
> apply to SELinux as well. I do not understand why
> SELinux developers feel so threatened by alternatives.

We're not threatened by alternatives.  We're concerned about a
technically unsound approach.  The arguments being raised against
pathname-based access control are about the soundness of that technical
approach, not whether there should be any alternatives to SELinux.

-- 
Stephen Smalley
National Security Agency

