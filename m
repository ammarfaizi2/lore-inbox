Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130147AbRAAAs3>; Sun, 31 Dec 2000 19:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131179AbRAAAsU>; Sun, 31 Dec 2000 19:48:20 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:20462
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S130147AbRAAAsJ>; Sun, 31 Dec 2000 19:48:09 -0500
Date: Sun, 31 Dec 2000 17:16:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: J Sloan <jjs@pobox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-prerelease
Message-ID: <20001231171653.F4703@opus.bloom.county>
In-Reply-To: <3A4FB558.688EFE01@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A4FB558.688EFE01@pobox.com>; from jjs@pobox.com on Sun, Dec 31, 2000 at 02:38:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 02:38:16PM -0800, J Sloan wrote:

> Of course, adding
> 
> #include <linux/modversions.h>
>
> to drivers/char/drm/drmP.h makes it all work....

Right, but that _shouldn't_ be needed.  iirc, modversions.h should be included
when needed, so this is covering up the bug not fixing it.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
