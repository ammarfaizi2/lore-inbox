Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWDXMzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWDXMzb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 08:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWDXMzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 08:55:31 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:33699 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750770AbWDXMza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 08:55:30 -0400
Date: Mon, 24 Apr 2006 07:55:28 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
       Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060424125528.GC9311@sergelap.austin.ibm.com>
References: <4445484F.1050006@novell.com> <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu> <4446D378.8050406@novell.com> <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu> <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com> <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu> <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com> <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu> <20060424082424.GH440@marowsky-bree.de> <1145882551.29648.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145882551.29648.23.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> On Llu, 2006-04-24 at 10:24 +0200, Lars Marowsky-Bree wrote:
> > On 2006-04-23T05:45:34, Valdis.Kletnieks@vt.edu wrote:
> > 
> > > > AppArmor are not likely to put careful thought into the policies that
> > > > they use?
> > > They're not likely to put careful thought into it, *AND* that saying things
> > > like "AppArmor is so *simple* to configure" only makes things worse - this
> > > encourages unqualified people to create broken policy configurations.
> > 
> > That is about the dumbest argument I've heard so far, sorry. 
> 
> Its the conclusion of most security experts I know that broken security
> is worse than no security at all. 

who is the one here showing blind faith in their security?  :)

Now don't get me wrong, I run static analysis tools against selinux
pretty regularly, and while the userspace tools get more and more scary
(as they are under development), the only thing I find in the kernel
code is the occasional unused variable.  And I'm not arguing any flaws
in the model, which indeed is more robust than the AA model.  But if
anyone is certain there are/can be no bugs in the rest of the kernel
which can circumvent selinux, or has perfect faith in their policy, then
your statement likely applies to them.

So as long as the kernel is under development, then by your logic one
might argue that using selinux, even if it is perfect in itself, is more
dangerous than using nothing.

-serge
