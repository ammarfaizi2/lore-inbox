Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbWFINDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbWFINDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 09:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWFINDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 09:03:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:53452 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965247AbWFINDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 09:03:22 -0400
Date: Fri, 9 Jun 2006 08:02:26 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Dave Hansen <haveblue@us.ibm.com>, Hubertus Franke <frankeh@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: 2.6.18 -mm merge plans
Message-ID: <20060609130226.GA718@sergelap.austin.ibm.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605144328.GA12904@sergelap.austin.ibm.com> <m17j3r8lqd.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j3r8lqd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> > Eric, Kirill, Dave, Hubertus,
> >
> > In the spirit of 'faster, please', does someone care to port and
> > resubmit a pidspace patch?
> 
> I think I can get that one. Except for the very tail end though
> most of my patches probably won't be directly pidspace patches.
> I'm going to work on killing sys_sysctl a little before I
> get to far into that.   A pidspace is one of the most controversial
> patches so it is a bit tricky.
> 
> > I'll do it if noone else wants to, just don't want to step on anyone's
> > toes if you were already working on it.
> 
> If you want to help with the bare pid to struct pid conversion I
> don't have any outstanding patches, and getting that done kills
> some theoretical pid wrap around problems as well as laying the ground
> work for a simple pidspace implementation.

Yeah, I'll get going on that over the next week.  A quick lxr search
shows quite a few remaining hits on pid_t  :)

-serge
