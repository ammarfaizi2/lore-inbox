Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285585AbRLGWHl>; Fri, 7 Dec 2001 17:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285598AbRLGWHY>; Fri, 7 Dec 2001 17:07:24 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:37646 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S285594AbRLGWHC>; Fri, 7 Dec 2001 17:07:02 -0500
Message-ID: <3C113D78.F324F1B9@delusion.de>
Date: Fri, 07 Dec 2001 23:06:48 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "David C. Hansen" <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@zip.com.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: release() locking
In-Reply-To: <3C10D83E.81261D74@delusion.de> <3C10FDCF.D8E473A0@zip.com.au> <3C11394D.90101@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David C. Hansen" wrote:

> I'm responsible for the release locking changes.  But, I don't think
> that the problems are a result of those changes.  There have been some
> other patches that might have caused the problem.  Take a look at this
> thread:

> Jens Axboe posted a patch.  I asked him:
> [...]

The patch that Jens posted was the fix for the oops I posted. The oops
was related to the bio stuff and not to the release() locking. I only
mentioned the keyboard stuff because I initially didn't know if there
was any connection between that and the oops.

> Udo, did you apply the patch that Jens sent?

Yes - and it cured the oops (the one in the thread you refer to), however
the keyboard problems are still there.

I guess there's something wrong with the changes you made, and it only
shows with the modifications that Andrew made - and since he says he
only fixed some bits of the code, the broken bits must have been there
before.

Regards,
Udo.
