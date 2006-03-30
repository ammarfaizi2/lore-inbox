Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWC3Ozu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWC3Ozu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWC3Ozu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:55:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46284 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750743AbWC3Ozq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:55:46 -0500
Date: Thu, 30 Mar 2006 08:55:44 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Chris Wright <chrisw@sous-sol.org>,
       Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060330145544.GA2403@sergelap.austin.ibm.com>
References: <44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com> <20060330013618.GS15997@sorel.sous-sol.org> <20060330132922.GB6933@sergelap.austin.ibm.com> <m1r74kcaux.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r74kcaux.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > Quoting Chris Wright (chrisw@sous-sol.org):
> >> * Eric W. Biederman (ebiederm@xmission.com) wrote:
> >> > At least one implementation Linux Jails by Serge E. Hallyn was done
> > completely
> >> > with security modules, and the code was pretty minimal.
> >> 
> >> Yes, although the networking area was something that looked better done
> >> via namespaces (at least that's my recollection of my conversations with
> >> Serge on that one a few years back).
> >
> > Yes, namespaces would be better - just as the file system isolation was
> > moved from a "strong chroot" approach to using pivot-root.  Though note
> > that vserver still uses basically the method that bsdjail uses, and my
> > two attempts at getting network namespaces considered in the kernel so
> > far were dismal failures.  Hopefully this time we've got some better,
> > more network-savvy minds on the task  :)
> 
> Any pointers to those old discussions?

I can only find the one.

http://marc.theaimsgroup.com/?l=linux-netdev&m=109837694221901&w=2

I thought I'd sent one earlier than this too.  Maybe I just got ready to
resend a new version, then decided the code quality wasn't worth it.

> I'm curious why getting your network namespaces were dismal failures.

Ok, I guess "dismal failure" most aptly applies to the patch itself :)

> Everyone ignored the patch?

Well, there was that.  Then I briefly tried to rework the patch, but
just ran out of time, and have kept this on my todo list ever since,
but never really gotten back to it.  At last it looks like this may
finally be coming back up.

-serge

