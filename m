Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWETA7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWETA7V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 20:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWETA7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 20:59:21 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:50320 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751455AbWETA7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 20:59:20 -0400
Subject: Re: [PATCH 0/9] namespaces: Introduction
From: Sam Vilain <sam@vilain.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com,
       Jeff Dike <jdike@addtoit.com>
In-Reply-To: <m1ves2z1fq.fsf@ebiederm.dsl.xmission.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	 <20060518103430.080e3523.akpm@osdl.org>
	 <m1ves2z1fq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sat, 20 May 2006 12:16:11 +1200
Message-Id: <1148084171.7103.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 05:41 -0600, Eric W. Biederman wrote:
> >    It would help set minds at ease if someone could produce a
> >    bullet-point list of what features the kernel will need to get it to the
> >    stage where "most or all vserver and openvz functionality can be
> >    implemented by controlling resource namespaces from userspace." Then we
> >    can discuss that list, make sure that everyone's pretty much in
> >    agreement.
> So this is slightly the wrong question.  If you look at Sam's list you

Yes - the wrong question because it's too top down and encourages
hacks :)  It's wrong for the purposes of planning an implementation, but
ok for easing minds about what will be covered, I think.

> will see that there are several independent dimensions to the complete
> solution.  Most of them dealing with the increase in the number of users
> and the amount of work that is happening on a single kernel in this
> context.
> 
> Basically we need to expect a lot of kernel tuning after we get the
> basics working. 
> 
> The proper question is: What needs to happen before we can run separate
> user space instances?

My guess would be most of the points under "isolation".  The others are
really just fine tuning / resource partitioning and fixing various
things that break under virtualisation because of their design (eg,
quota).

Sam.

