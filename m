Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVCUTm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVCUTm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVCUTm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:42:28 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:31251 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S261348AbVCUTmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:42:23 -0500
Message-ID: <423F0C67.6000006@lougher.demon.co.uk>
Date: Mon, 21 Mar 2005 18:03:19 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <423EEEC2.9060102@lougher.demon.co.uk> <20050321190044.GD1390@elf.ucw.cz>
In-Reply-To: <20050321190044.GD1390@elf.ucw.cz>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> 
> Well, out-of-tree maintainenance takes lot of time, too, so by keeping
> limited code out-of-kernel we provide quite good incentive to make
> those limits go away.

Sorry but I'm not calling Squashfs "limited" and I don't think it is. 
If you wanted to nit-pick many of the current filesystems in the kernel 
have various "limitations".

Your comment about not wanting more than one compressed filesystem in 
the kernel is groundless.  There's lots of _uncompressed_ filesystems in 
the kernel, why do we need them all?  Let's just pick one and throw the 
rest away?  Hmmm?  Anyway there's already three compressed filesystems 
in the kernel, each doing various specialised tasks: jffs2, zisofs, and 
cramfs.  No objections were raised then, why now?

As for your comment about "proving good incentive to make those limits 
go away", in many cases it's more likely to make people give up and walk 
away from any further kernel work.


> 
> Perhaps squashfs is good enough improvement over cramfs... But I'd
> like those 4Gb limits to go away.

So would I.  But it is a totally groundless reason to refuse kernel 
submission because of that, Squashfs users are quite happily using it 
with such a "terrible" limitation.  I'm asking for Squashfs to be put in 
the kernel _now_ because users are asking me to do it _now_.  If it 
doesn't go in, then they'll want to know why the kernel clique has 
become so unreceptive to new pieces of work which they consider a key 
piece of their Linux 'experience', and for that matter so would I.

Phillip
