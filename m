Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUIIUhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUIIUhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUIIUhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:37:33 -0400
Received: from nudibranch.mweb.co.za ([196.2.50.74]:32146 "EHLO
	nudibranch.mweb.co.za") by vger.kernel.org with ESMTP
	id S265517AbUIIUhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:37:24 -0400
Date: Thu, 9 Sep 2004 22:39:40 +0000
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Richard A Nelson <cowboy@debian.org>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: 2.6.9-rc1-mm4 kjournald oops (repeatable)
Message-ID: <20040909223940.278250b4@localhost>
In-Reply-To: <1094761240.3047.12.camel@sisko.scot.redhat.com>
References: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
	<20040908020402.3823a658.akpm@osdl.org>
	<1094635403.1985.12.camel@sisko.scot.redhat.com>
	<Pine.LNX.4.58.0409081011170.7419@hygvzn-guhyr.pnirva.bet>
	<Pine.LNX.4.58.0409081604060.6248@hygvzn-guhyr.pnirva.bet>
	<1094685396.1362.245.camel@krustophenia.net>
	<Pine.LNX.4.58.0409081644150.6248@hygvzn-guhyr.pnirva.bet>
	<20040909215611.47484cd8@localhost>
	<1094761240.3047.12.camel@sisko.scot.redhat.com>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__9_Sep_2004_22_39_40_+0000_JVAUjamjL_263Qc1"
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__9_Sep_2004_22_39_40_+0000_JVAUjamjL_263Qc1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On 09 Sep 2004 21:20:40 +0100
"Stephen C. Tweedie" <sct@redhat.com> wrote:

> Hi,
> 
> On Thu, 2004-09-09 at 22:56, Bongani Hlope wrote:
> 
> > Ok it seem I'm not the only one. Ive bee trying to find this for a
> > while. It seems to happen on 2.6.9rc1-mm[24] kernels (I haven't tried
> > mm[13] ). I was only able to capture the Oops this morning (pen and
> > paper) I also have preempt enabled. This only happens on my PII though
> > (Mandrake cooker updates and kernel compiles), my dual opteron has
> > been running this since last night without any problems (gentoo sync
> > and kernel compile), also with preempt 
> 
> The journal_clean_checkpoint_list-latency-fix.patch was added in
> 2.6.9rc1-mm2 and is still there in mm4, so your problem is also
> consistent with a bug in that patch; could you try backing that one diff
> out and seeing if it fixes it for you too?
> 
> Thanks,
>  Stephen
> 

Busy compiling, I'll let you know how it goes.
Thanx

--Signature=_Thu__9_Sep_2004_22_39_40_+0000_JVAUjamjL_263Qc1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBQNu1+pvEqv8+FEMRAot8AJ4tElqzfZ2R1bXDOI69u2Kv9IcztwCeLyXL
UEZbg+6ik2yu92652Ew+ilY=
=cxwZ
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Sep_2004_22_39_40_+0000_JVAUjamjL_263Qc1--
