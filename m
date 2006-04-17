Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWDQWQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWDQWQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWDQWQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:16:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:55512 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751350AbWDQWQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:16:40 -0400
To: James Morris <jmorris@namei.org>
cc: "Serge E. Hallyn" <serue@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks 
In-reply-to: Your message of Mon, 17 Apr 2006 15:31:08 EDT.
             <Pine.LNX.4.64.0604171528340.17923@d.namei> 
Date: Mon, 17 Apr 2006 15:15:29 -0700
Message-Id: <E1FVc0H-00077d-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Apr 2006 15:31:08 EDT, James Morris wrote:
> On Mon, 17 Apr 2006, Serge E. Hallyn wrote:
> 
> > Hopefully a new version of evm+slim+ima will be ready for distribution
> > soon.
> 
> Why are you still trying to introduce yet another access control model 
> into the kernel, when SELinux is already there?

I get the impression from customers that SELinux is so painful to
configure correctly that most of them disable it.  In theory, LSM +
something like AppArmour provides a much simpler security model for
normal human beings who want some level of configuration.  Also,
the current SELinux config in RH is starting to have a measureable
performance impact.  I'm not sure this particular battle of the
security models is quite over from a real user perspective.

gerrit
