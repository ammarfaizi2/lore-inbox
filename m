Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWDQXJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWDQXJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 19:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWDQXJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 19:09:43 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:12417 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750876AbWDQXJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 19:09:43 -0400
Date: Mon, 17 Apr 2006 16:09:23 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060417230923.GG3615@sorel.sous-sol.org>
References: <Pine.LNX.4.64.0604171528340.17923@d.namei> <E1FVc0H-00077d-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FVc0H-00077d-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gerrit Huizenga (gh@us.ibm.com) wrote:
> I get the impression from customers that SELinux is so painful to
> configure correctly that most of them disable it.  In theory, LSM +
> something like AppArmour provides a much simpler security model for
> normal human beings who want some level of configuration.  Also,
> the current SELinux config in RH is starting to have a measureable
> performance impact.  I'm not sure this particular battle of the
> security models is quite over from a real user perspective.

SELinux usability is not the same issue as having LSM in the kernel.
So, I agree, usability can improve, but having AppArmor as external
patchkit is not helping show LSM is needed in upstream tree.  It needs
to survive review and get upstream as a means to showing the use of LSM.

thanks,
-chris
