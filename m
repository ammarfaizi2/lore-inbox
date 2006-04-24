Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWDXNwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWDXNwR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDXNwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:52:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15296 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750811AbWDXNwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:52:15 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
       Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060424125641.GD9311@sergelap.austin.ibm.com>
References: <4445484F.1050006@novell.com>
	 <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu>
	 <4446D378.8050406@novell.com>
	 <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
	 <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
	 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
	 <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
	 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
	 <20060424082424.GH440@marowsky-bree.de>
	 <1145882551.29648.23.camel@localhost.localdomain>
	 <20060424125641.GD9311@sergelap.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 15:02:13 +0100
Message-Id: <1145887333.29648.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 07:56 -0500, Serge E. Hallyn wrote:
> By the way, this is predicated on the assumption that the broken
> security will cause the user to expose more data.  However in many cases
> these days, that is sadly not the case.  Amazon will store my cc data
> regardless whether they are running selinux, apparmor, or nothing.

There I disagree. They will store your CC data in a manner that is held
to be reasonable depending on the technology and risk. If "nothing" was
the security available (eg if the US had won the Bernstein case) then
you'd be phoning them to complete your order versus using https://

They are constrained by economic pressures not to screw up, strongly
amplified by the size of the class action lawsuit if their security
policy was found by most experts to be inadequate (ie negligent).

For end users the threat is probably loss of credit cards, pay pal and
other accounts for the moment, plus being used for zombie attacks. At
the moment nobody knows where the 'negligence' line is for not
maintaining your PC systems securely and as a result harming others.

The theoretical bad case is someone with more a militaristic agenda
deciding it would be fun to irrevocably lock every hard disk on every
computer in a US locale.

Thus this sort of stuff needs to be taken seriously. Can SuSE provide a
good reliable policy for AppArmour to people, can Red Hat do the same
with SELinux ?

Note I don't care about whether apparmour is integrated. If the code is
good and it can be shown it works then fine.


