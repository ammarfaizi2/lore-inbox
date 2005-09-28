Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbVI1Ihy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVI1Ihy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 04:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbVI1Ihy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 04:37:54 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:18560 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1030215AbVI1Ihx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 04:37:53 -0400
Message-ID: <433A55F0.5060809@cs.aau.dk>
Date: Wed, 28 Sep 2005 10:36:00 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>, 7eggert@gmx.de
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
References: <4Rne4-4sd-3@gated-at.bofh.it> <4Rq2b-i7-1@gated-at.bofh.it> <E1EKSQx-0002Pf-M5@be1.lrz>
In-Reply-To: <E1EKSQx-0002Pf-M5@be1.lrz>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> 
> You can actually try to probe the legacy ports like LPT and COM if you've
> got the correct permissions. However, you SHOULD avoid any port except the
> default port ranges and ask the user for non-standard hardware and you
> SHOULD NOT touch devices being in use.
> 
> Each piece of hardware will be different, and you'll fell like having opened
> a large freight container of worms.

But you are speaking about printer/scanner/... or other external
devices, isn't it ?

Do you think they should be included in the automatic detection ? Or
would it be safer to let the user make the configuration by himself ?

As you pointed it out, it requires special rights and might actually be
dangerous. I'm not sure that this is worthing to try.

My view of this "autoconfig" was more to detect what is present in the
box, not what is lying outside...

Regards
-- 
Emmanuel Fleury

Security is a process, not a product.
  -- Bruce Schneier (Crypto-gram, February 15, 2002)
