Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbREXQ47>; Thu, 24 May 2001 12:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbREXQ4s>; Thu, 24 May 2001 12:56:48 -0400
Received: from idiom.com ([216.240.32.1]:40716 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S261385AbREXQ4j>;
	Thu, 24 May 2001 12:56:39 -0400
Message-ID: <3B0D3C99.255B5A24@namesys.com>
Date: Thu, 24 May 2001 09:53:45 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: Dying disk and filesystem choice.
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au> <200105240658.f4O6wEWq031945@webber.adilger.int> <20010524103145.A9521@gruyere.muc.suse.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Thu, May 24, 2001 at 12:58:14AM -0600, Andreas Dilger wrote:
> > Well reiserfs is probably a very bad choice at this point.  It
> > does not have any bad blocks support (yet), so as soon as you have
> > a bad block you are stuck.
> 
> reiserfs doesn't, but the HD usually has transparently in its firmware.
> So it hits a bad block; you see an IO error and the next time you hit
> the block the firmware has mapped in a fresh one from its internal
> reserves.
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


No, reiserfs does have badblock support!!!!

You just have to get it as a separate patch from us because it was written after
code freeze.

Hans
