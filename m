Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIIKr>; Tue, 9 Jan 2001 03:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRAIIK2>; Tue, 9 Jan 2001 03:10:28 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:64243 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S129383AbRAIIKT>;
	Tue, 9 Jan 2001 03:10:19 -0500
Date: Tue, 9 Jan 2001 09:09:36 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010109090936.A2900@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20010108213036.T27646@athlon.random> <Pine.GSO.4.21.0101081537570.4061-100000@weyl.math.psu.edu> <20010108225605.Y27646@athlon.random> <93diet$aqc$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <93diet$aqc$1@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jan 08, 2001 at 03:28:29PM -0800
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 03:28:29PM -0800, Linus Torvalds wrote:

> But at least "rmdir `pwd`" is not _required_ to fail, like rmdir("."/"..").

"rmdir `pwd`" is required to fail (at least under csh, bash, ksh) if the
path component contains a white space and thereof it can't be a valid
replacement for Andreas "rmdir ." which was what Al initially suggested.

Yes, I'm very pickey about that; but hey, I don't want to force anyone
to write GNU/Linux like rms; just valid shell code. :)

I hope you now agree that "rmdir `pwd`" makes not much sense - except in
bug reports for bash, csh and ksh scripts or in scripts dedicated to
the Win32 environment :)

-- 

  ciao - 
    Stefan

" Lession 1: Quoting.                   Lession 2: Power up the machine. "
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
