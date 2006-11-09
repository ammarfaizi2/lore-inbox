Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424248AbWKIXR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424248AbWKIXR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424250AbWKIXR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:17:26 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:60937 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1424248AbWKIXRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:17:25 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] sysctl: Undeprecate sys_sysctl
Date: Thu, 9 Nov 2006 23:17:26 +0000
User-Agent: KMail/1.9.5
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611092317.26459.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 November 2006 19:00, you wrote:
> The basic issue is that despite have been deprecated and warned about
> as a very bad thing in the man pages since its inception there are a
> few real users of sys_sysctl.  It was my assumption that because
> sysctl had been deprecated for all of 2.6 there would be no user space
> users by this point, so I initially gave sys_sysctl a very short
> deprecation period.
>
> Now that I know there are a few real users the only sane way to
> proceed with deprecation is to push the time limit out to a year or
> two work and work with distributions that have big testing pools like
> fedora core to find these last remaining users.

Eric, do you have a list of the remaining users? It'd be good to know for 
people using Linux in an embedded environment, where they may want to switch 
off the option, but only if it doesn't break their userspace.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
