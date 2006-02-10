Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWBJPMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWBJPMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWBJPMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:12:40 -0500
Received: from mail12.bluewin.ch ([195.186.19.61]:17035 "EHLO
	mail12.bluewin.ch") by vger.kernel.org with ESMTP id S1751280AbWBJPMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:12:40 -0500
Date: Fri, 10 Feb 2006 10:11:40 -0500
To: Nico Schottelius <nico-kernel2@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>, neilb@cse.unsw.edu.au,
       Gero Kuhlmann <gero@gkminix.han.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>
Subject: Re: [RESEND] [PATCH] nfsroot.txt (against Linux 2.6.15.2)
Message-ID: <20060210151140.GA14516@krypton>
References: <20060210084508.GB11533@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210084508.GB11533@schottelius.org>
User-Agent: Mutt/1.5.11
From: apgo@patchbomb.org (Arthur Othieno)
X-FXIT-IP: 83.76.96.94
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 09:45:08AM +0100, Nico Schottelius wrote:
> [This message was sent to the LKML on Mon, 6 Feb 2006 16:29:46 +0100
>  and nobody replied. Perhaps you did not see it in the flood of mails.]
> 
> Hello dear developers,
> 
> I today booted the first time my embedded device using Linux 2.6.15.2,
> which was booted by pxelinux, which then bootet itself from the nfsroot.
> 
> This went pretty fine, but when I was reading through
> Documentation/nfsroot.txt I saw that there are some more modern versions
> available of loading the kernel and passing parameters.

Looks good.

> So I added them and the patch for that is attached to this mail.

Inline patches preferred.

> Sincerly,
> 
> Nico
> 
> P.S.: Please reply to nico-kernel2 //at// schottelius.org
 
Easier if this is your From: address, initially ;-)

> --- nfsroot.txt.orig	2006-02-06 16:05:32.000000000 +0100
> +++ nfsroot.txt	2006-02-06 16:19:37.000000000 +0100
> @@ -3,6 +3,7 @@

Patches must be in a format that applies with `diff -p1'. diffstat(1)
output doesn't hurt, either. See Documentation/SubmittingPatches and
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt for details.

[ snip ]
