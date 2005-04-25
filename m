Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVDYR2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVDYR2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVDYRZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:25:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:61634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262673AbVDYRVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:21:46 -0400
Date: Mon, 25 Apr 2005 10:23:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
cc: git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
In-Reply-To: <426D21FE.3040401@tiscali.de>
Message-ID: <Pine.LNX.4.58.0504251021280.18901@ppc970.osdl.org>
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
 <426D21FE.3040401@tiscali.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Apr 2005, Matthias-Christian Ott wrote:
>
> "register" and "auto" variables aren't relicts of the 60's,  they're a 
> part of the ISO-C 99 standard, I'm following, "man".

They _are_ relicts of the 60's. It's just that the C standard hasn't ever 
had the reason to remove them.

> And if you think "register" variables are outdated, please remove the 
> CONFIG_REGPARM option from the Kernel source.

That does something totally different. And doesn't use "register" at all.

Pass the toke, you've been hogging the drugs for way too long.

		Linus
