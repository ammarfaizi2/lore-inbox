Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWC3N3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWC3N3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWC3N3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:29:51 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:21652 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932208AbWC3N3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:29:50 -0500
Date: Thu, 30 Mar 2006 07:29:22 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Sam Vilain <sam@vilain.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060330132922.GB6933@sergelap.austin.ibm.com>
References: <4428FB29.8020402@yahoo.com.au> <20060328142639.GE14576@MAIL.13thfloor.at> <44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com> <20060330013618.GS15997@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330013618.GS15997@sorel.sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@sous-sol.org):
> * Eric W. Biederman (ebiederm@xmission.com) wrote:
> > At least one implementation Linux Jails by Serge E. Hallyn was done completely
> > with security modules, and the code was pretty minimal.
> 
> Yes, although the networking area was something that looked better done
> via namespaces (at least that's my recollection of my conversations with
> Serge on that one a few years back).

Yes, namespaces would be better - just as the file system isolation was
moved from a "strong chroot" approach to using pivot-root.  Though note
that vserver still uses basically the method that bsdjail uses, and my
two attempts at getting network namespaces considered in the kernel so
far were dismal failures.  Hopefully this time we've got some better,
more network-savvy minds on the task  :)

-serge
