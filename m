Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbVCEAnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbVCEAnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263516AbVCEAkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:40:09 -0500
Received: from orb.pobox.com ([207.8.226.5]:44972 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S263318AbVCEAOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:14:31 -0500
Date: Fri, 4 Mar 2005 16:14:22 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050305001422.GF9796@ip68-4-98-123.oc.oc.cox.net>
References: <20050303160330.5db86db7.akpm@osdl.org> <20050304025746.GD26085@tolot.miese-zwerge.org> <20050303213005.59a30ae6.akpm@osdl.org> <1109924470.4032.105.camel@tglx.tec.linutronix.de> <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de> <20050304012154.619948d7.akpm@osdl.org> <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org> <4228A9B9.4060308@pobox.com> <4228B1EB.4040503@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4228B1EB.4040503@mesatop.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 12:07:23PM -0700, Steven Cole wrote:
> 
> Here's an idea which might just be too simple, but here it is anyway:
> 
> Modifiy the bk snapshot scripts to name the 2.6.x series snapshots as -PREy
> instead of -BKy.  That way, the general population of users will see
> the -bk snapshots as -pre releases.  According to Linus, pre == bk.  So,
> name them as such.

I heartily second this!! If "pre" == "bk", then make it "pre"!

> Linus, wait for at least two weeks before releasing the first -rc.
> That way, the bulk on the thundering herd of patches will be hopefully
> be merged by then.  And users will have 2.6.x-PRE[1..14] to test.
> The hard part for the kernel.org script writer might be to disable
> the -bk/-pre snapshot once the first -rc is out.

Errh... personally, I find the -rc-bk snapshots to be useful sync
points. They're also what seems to make it into davej's
"rawhide"/"fc-devel" Fedora testing kernels. (Perhaps those don't get
widely tested, but they do get *some* testing -- e.g. they're how I
managed to hit (and get fixed) the TCP stack overflow.)

I guess the best thing would be for the script to revert to the current
("-bk") naming scheme once -rc1 is out. Otherwise it would need to do,
say, 2.6.12-rc2-pre1 instead of 2.6.12-rc1-bk1, and while that seems
natural to me, I don't know how the rest of the planet's human population
would react...

-Barry K. Nathan <barryn@pobox.com>

