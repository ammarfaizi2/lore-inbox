Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbUJZSCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUJZSCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUJZSBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:01:35 -0400
Received: from hera.kernel.org ([63.209.29.2]:39850 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261369AbUJZSA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:00:26 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: My thoughts on the "new development model"
Date: Tue, 26 Oct 2004 11:01:45 -0700
Organization: Open Source Development Lab
Message-ID: <20041026110145.1a0052e4@zqx3.pdx.osdl.net>
References: <7aaed09104102213032c0d7415@mail.gmail.com>
	<7aaed09104102214521e90c27c@mail.gmail.com>
	<417E74DD.6000203@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Trace: build.pdx.osdl.net 1098813621 16367 172.20.1.73 (26 Oct 2004 18:00:21 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 26 Oct 2004 18:00:21 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-suse-linux)
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by hera.kernel.org id i9QI0MaA014095
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 12:01:33 -0400
John Richard Moser <nigelenki@comcast.net> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Espen Fjellvær Olsen wrote:
> | This may come a bit late now, since the "new development model" was
> | put through late this summer.
> | But anyway i'm going to come with som thoughts about it.
> |
> | I think that 2.6 should be frozen from now on, just security related
> | stuff should be merged.
> | This would strengthen Linux's reputation as a stable and secure
> | system, not a unstable and a system just used for fun.
> | A 2.7 should be created where all new experimental stuff is merged
> | into it, and where people could begin to think new again.
> | New thoughts are good in all ways, it is for sure very much code in
> | the current kernels that should be revised, rewritten and maybe marked
> | as deprecated.
> |
> | :)
> 
> I agree fully.
> 
> I've been quite worried and annoyed.  While I do think the newest
> releases and the changes in 2.6.9 and .10 are damn cool, and i want
> them, I also won't let go of PaX.  PaX stopped at 2.6.7 because of
> internal VM changes; the kernel's unstable state is making it an undue
> amount of work for the PaX team to update PaX for the newest kernels.
> If all the time is spent porting it up to the new VM changes, then there
> is no time for bugfixes and improvements.
> 
> PaX is a core component of GrSecurity as well; as long as the PaX
> project is halted at 2.6.7, GrSec can't pass 2.6.7.  How many other
> projects are going to sit at 2.6.7, or are going to spend too much time
> up-porting and not enough time bugfixing and enhancing?
>

The Linux development model is not setup to be convenient for out of tree
kernel development. This is intentional, if the project is out of tree no
kernel developer is going to see it or fix it. Submit it and get it reviewed
and into the process or quit complaining and make and maintain your
own "stable" tree.

> I do not propose freezing *now* if it's not convenient; I say you pick
> what you want to finish up (maybe some of the Montavista stuff; I'd
> personally like voluntary pre-empt and friends at least), get that in,
> and slate any new developments for a 2.6.7 branch to be forked off
> whenever is appropriate.

Everyone's list of what they want added to 2.6 is different. So the
kernel work continues and is the union of everyone's good ideas (and
a few bad ones).



