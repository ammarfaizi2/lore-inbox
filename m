Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266179AbUGJHDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266179AbUGJHDT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 03:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbUGJHDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 03:03:19 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:42405 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266175AbUGJHDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 03:03:11 -0400
Date: Sat, 10 Jul 2004 09:02:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "P. Benie" <pjb1008@eng.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040710070255.GG20947@dualathlon.random>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.53.0407080707010.21439@chaos> <Pine.HPX.4.58L.0407081224460.28859@punch.eng.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.58L.0407081224460.28859@punch.eng.cam.ac.uk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 12:43:16PM +0100, P. Benie wrote:
> the integer 0 and null pointers are not the same, the compiler will
> perform the appropriate conversion for you, so it is always correct to
> define NULL as (void *)0.

exactly, the compiler knows about that.

> Personally, I always use 0 and NULL for integers and null pointers
> respectively, but that's because of long estalished conventions that make
> the code readabile, rather than anything to do with validity of the code.

Yep.
