Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131385AbQKXAJy>; Thu, 23 Nov 2000 19:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131403AbQKXAJo>; Thu, 23 Nov 2000 19:09:44 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:3590 "EHLO havoc.gtf.org")
        by vger.kernel.org with ESMTP id <S131385AbQKXAJ2>;
        Thu, 23 Nov 2000 19:09:28 -0500
Message-ID: <3A1DAAAD.28786302@mandrakesoft.com>
Date: Thu, 23 Nov 2000 18:39:25 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bernd Eckenfels <ecki@lina.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: beware of dead string constants
In-Reply-To: <E13z5nt-0007ig-00@calista.inka.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> 
> In article <14874.25691.629724.306563@wire.cadcamlab.org> you wrote:
> > This is mostly a heads-up to say that in this regard gcc is not ready
> > for prime time, so we really can't get away with using if() as an ifdef
> > yet, at least not without penalty.
> 
> Humm.. whats the Advantage of this?

Advantage of what?

If you mean preferring 'if ()' over 'ifdef'... Linus.  :)  And I agree
with him:  code looks -much- more clean without ifdefs.  And the
compiler should be smart enough to completely eliminate code inside an
'if (0)' code block.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
