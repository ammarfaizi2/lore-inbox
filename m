Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271685AbTHHPsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271686AbTHHPsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:48:47 -0400
Received: from pat.uio.no ([129.240.130.16]:23267 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S271685AbTHHPso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:48:44 -0400
To: Timothy Miller <miller@techsource.com>, Jasper Spaans <jasper@vs19.net>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
References: <20030807180032.GA16957@spaans.vs19.net>
	<Pine.LNX.4.53.0308072139320.12875@montezuma.mastecende.com>
	<20030808065230.GA5996@spaans.vs19.net>
	<3F33BF33.8070601@techsource.com>
	<Pine.LNX.4.53.0308081127160.502@chaos>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 08 Aug 2003 17:48:30 +0200
In-Reply-To: <Pine.LNX.4.53.0308081127160.502@chaos>
Message-ID: <shsekzwi20h.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



    >> >>>It changes all occurrences of 'flavour' to 'flavor' in the
    >> >>>complete tree; I've just comiled all affected files (that
    >> >>>is, the config resulting from make allyesconfig minus
    >> >>>already broken stuff) succesfully on i386.
    >> >>
    >> >>Arrrgh! You can't be serious!
    >> >
    >> >
    >> > Yes, I am bloody serious; this patch might look purely
    >> > cosmetic at first sight.. yet, there's a technical reason for
    >> > at least one part of it. Grep and see the horror:
    >> >
    >> > $ egrep -ni 'flavou?r' fs/nfs/inode.c [snip] 1357:
    >> > rpc_authflavor_t authflavour; [snip]
    >>

Anybody who screws with that spelling is setting himself up for the
red hot poker treatment...

The flavor/flavour thing reflects the fact that the code has been
written and modified by different people with different
backgrounds. Some people have been unfortunate enough to be of the US
persuasion, others have grown up with the British spelling.

Now leave it alone and go do something useful with your lives...

Trond
