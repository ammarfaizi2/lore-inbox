Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTENCl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 22:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTENCl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 22:41:27 -0400
Received: from CPE-24-163-212-250.mn.rr.com ([24.163.212.250]:59523 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S261901AbTENClQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 22:41:16 -0400
Subject: Re: odd db4 error with 2.5.69-mm4 [was Re: Huraaa for 2.5]
From: Shawn <core@enodev.com>
To: J Sloan <joe@tmsusa.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1052880432.3569.34.camel@www.enodev.com>
References: <1052866461.23191.4.camel@www.enodev.com>
	 <20030514012731.GF8978@holomorphy.com>
	 <1052877161.3569.17.camel@www.enodev.com>  <3EC1AAC4.1010104@tmsusa.com>
	 <1052880432.3569.34.camel@www.enodev.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1052880712.3569.40.camel@www.enodev.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 13 May 2003 21:51:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wait a second, there is no .2-1 on redhat. It must be how redhat
packages it...

Ope, there an email from -wli... Yup, that's the deal. bugzilla.redhat
time...

On Tue, 2003-05-13 at 21:47, Shawn wrote:
> I sure wish I knew what triggers this bug. it worked fine under 2.5.6x
> on rh 80 for me.
> 
> Ah crap. I'm running rpm-4.2-0.69 because rhn has been busy. FRICK.
> 
> On Tue, 2003-05-13 at 21:32, J Sloan wrote:
> > Shawn wrote:
> > 
> > >Not to get away from the praise too much, but I have a rpm/db4 problem
> > >that seems to be related to the kernel. before I started backing out
> > >parts of 69-mm4, I just wanted to figure out /which/ parts to try
> > >backing out.
> > >
> > >As root, I basically can't use rpm at all. I think it's select() related
> > >as strace shows it timing out. The odd thing is that it works great as a
> > >non-privileged user.
> > >
> > >2.5.69-mm4, otherwise mostly stock rh90 setup.
> > >
> > 
> > Just out of curiosity, have you tried:
> > 
> > LD_KERNEL_ASSUME=2.4.1 rpm -qi iptables
> > 
> > OTOH, rpm-4.2-1 seems to "just work" here -
> > 
> > where "here" is of the form:
> > 
> > 2.5.6x on RH9
> > 
> > Joe
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
