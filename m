Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWDYQSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWDYQSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWDYQSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:18:34 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:25474 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751559AbWDYQSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:18:33 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Marowsky-Bree <lmb@suse.de>,
       Valdis.Kletnieks@vt.edu, Ken Brush <kbrush@gmail.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060424140407.GD22703@sergelap.austin.ibm.com>
References: <4446D378.8050406@novell.com>
	 <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
	 <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
	 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
	 <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
	 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
	 <20060424082424.GH440@marowsky-bree.de>
	 <1145882551.29648.23.camel@localhost.localdomain>
	 <20060424125641.GD9311@sergelap.austin.ibm.com>
	 <1145887333.29648.44.camel@localhost.localdomain>
	 <20060424140407.GD22703@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 12:23:03 -0400
Message-Id: <1145982183.21399.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 09:04 -0500, Serge E. Hallyn wrote:
> Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> > Thus this sort of stuff needs to be taken seriously. Can SuSE provide a
> > good reliable policy for AppArmour to people, can Red Hat do the same
> > with SELinux ?
> 
> That's a little more than half the question.  The other 40% is can users
> write good policies.
> 
> I think it will, and already has, become easier for selinux.  But in
> this case I wonder whether some sort of contest could be beneficial.  We
> all know of Russel Coker's open root selinux play machines.  That's a
> powerful statement.  Things I'd like to see in addition are
> 
> 	a. a similar setup with apparmour
> 	b. a similar setup where "mere mortals" set up the selinux policy
> 
> For the first few rounds, rather than judge one way or the other, we
> could hopefully publish the results in a way to encourage a flurry of
> selinux policy tools - one of which may actually be useful.

Personally, I view such contests or challenge machines as meaningless.
At best, they can only show the presence of a flaw, never that the
system is "secure".  And the people most capable of breaking such
systems are not likely to go near such a play machine knowingly.  The
SELinux play machines were nice from an educational point of view,
allowing people to experiment with a SELinux system without needing to
install and set it up themselves, particularly in the days when SELinux
was not integrated into any distro.  But as a meaningful measure of
security, such contests or challenge/play machines aren't really useful.

-- 
Stephen Smalley
National Security Agency

