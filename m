Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWC2XMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWC2XMA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWC2XMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:12:00 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50306 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751230AbWC2XL7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:11:59 -0500
Date: Wed, 29 Mar 2006 15:13:15 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Sam Vilain <sam@vilain.net>
Cc: Chris Wright <chrisw@sous-sol.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060329231315.GP15997@sorel.sous-sol.org>
References: <20060328085206.GA14089@MAIL.13thfloor.at> <4428FB29.8020402@yahoo.com.au> <20060328142639.GE14576@MAIL.13thfloor.at> <44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <442B11CC.6040503@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442B11CC.6040503@vilain.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sam Vilain (sam@vilain.net) wrote:
> AIUI inode_ops are not globals, they are per FS.

Heh, yes really bad example.

> That to me reads as:
> 
> "To avoid having to consider making security_ops non-global we will
> force security modules to be container aware".

Not my intention.  Rather, I think from a security standpoint there's
sanity in controlling things with a single policy.  I'm thinking of
containers as a simple and logical extension of roles.  Point being,
the per-object security label can easily include notion of container.

> It also means you could not mix security modules that affect the same
> operation different containers on a system. Personally I don't care, I
> don't use them. But perhaps this inflexibility will bring problems later
> for some.

No issue with addressing these issues as they come.

thanks,
-chris
