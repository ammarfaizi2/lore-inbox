Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWDXOES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWDXOES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDXOES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:04:18 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:60369 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750826AbWDXOEQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:04:16 -0400
Date: Mon, 24 Apr 2006 09:04:07 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Lars Marowsky-Bree <lmb@suse.de>,
       Valdis.Kletnieks@vt.edu, Ken Brush <kbrush@gmail.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060424140407.GD22703@sergelap.austin.ibm.com>
References: <4446D378.8050406@novell.com> <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu> <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com> <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu> <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com> <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu> <20060424082424.GH440@marowsky-bree.de> <1145882551.29648.23.camel@localhost.localdomain> <20060424125641.GD9311@sergelap.austin.ibm.com> <1145887333.29648.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145887333.29648.44.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> Thus this sort of stuff needs to be taken seriously. Can SuSE provide a
> good reliable policy for AppArmour to people, can Red Hat do the same
> with SELinux ?

That's a little more than half the question.  The other 40% is can users
write good policies.

I think it will, and already has, become easier for selinux.  But in
this case I wonder whether some sort of contest could be beneficial.  We
all know of Russel Coker's open root selinux play machines.  That's a
powerful statement.  Things I'd like to see in addition are

	a. a similar setup with apparmour
	b. a similar setup where "mere mortals" set up the selinux policy

For the first few rounds, rather than judge one way or the other, we
could hopefully publish the results in a way to encourage a flurry of
selinux policy tools - one of which may actually be useful.

Given that AA is a 'targeted' type of setup, I guess it would need to
have a strict sshd policy, and the game would be whether the policy can
keep anyone with the root password from escaping the policy.

> Note I don't care about whether apparmour is integrated. If the code is
> good and it can be shown it works then fine.

thanks,
-serge
