Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVA3OL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVA3OL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 09:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVA3OL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 09:11:26 -0500
Received: from one.firstfloor.org ([213.235.205.2]:23267 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261703AbVA3OLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 09:11:24 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add compiler-gcc4.h
References: <20050130130308.GK3185@stusta.de>
From: Andi Kleen <ak@muc.de>
Date: Sun, 30 Jan 2005 15:11:19 +0100
In-Reply-To: <20050130130308.GK3185@stusta.de> (Adrian Bunk's message of
 "Sun, 30 Jan 2005 14:03:08 +0100")
Message-ID: <m1pszn3t2w.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> With the release of gcc 4.0 being only a few months away and people 
> already tring compiling with it, it's time for adding a compiler-gcc4.h .
>
> This patch contains the following changes:
> - compiler-gcc+.h: add the missing noinline and __compiler_offsetof
> - compiler-gcc4.h: new file based on the corrected compiler-gcc+.h
> - compiler.h: include compiler-gcc4.h for gcc 4
> - compiler-gcc3.h: remove __compiler_offsetof (there will never be a
>                                                gcc 3.5)
>                    small indention corrections

I don't think it makes much sense right now because it's basically
identical to compiler-gcc3.h. I would only add it where there is a 
need for a real difference.

-Andi
