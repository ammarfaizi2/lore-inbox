Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLLXIH>; Tue, 12 Dec 2000 18:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129521AbQLLXH5>; Tue, 12 Dec 2000 18:07:57 -0500
Received: from web.sajt.cz ([212.71.160.9]:48133 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S129383AbQLLXHw>;
	Tue, 12 Dec 2000 18:07:52 -0500
Date: Tue, 12 Dec 2000 23:34:45 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: David Woodhouse <dwmw2@infradead.org>
cc: ajapted@netspace.net.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mdacon.c cleanup 
In-Reply-To: <16970.976612511@redhat.com>
Message-ID: <Pine.LNX.4.21.0012122328310.26198-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Dec 2000, David Woodhouse wrote:

> pavel@web.sajt.cz said:
> > Both MODULE_PARM and __init are removed by precompiler when not
> > compiler as module, so no need for ifdefs.  2.4.0-test12pre8
> 
> -#ifdef MODULE_PARM
>  MODULE_PARM(mda_first_vc, "1-255i");
>  MODULE_PARM(mda_last_vc,  "1-255i");
> -#endif
> 
> That was #ifdef MODULE_PARM not #ifdef MODULE. Probably there for 
> compatibility with older kernels. Although I'm not sure it's even required 
> in 2.2.

MODULE_PARM is removed by precompiler, in both 2.2 and 2.4. For sure.
 
Pavel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
