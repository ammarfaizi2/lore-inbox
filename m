Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUH0Tna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUH0Tna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267472AbUH0Tna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:43:30 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:6272 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S267528AbUH0TYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:24:34 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: Re: Termination of the Philips Webcam Driver (pwc
Date: Fri, 27 Aug 2004 15:24:35 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408271524.35381.shawn.starr@rogers.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps it's time we just fork the driver and reverse engineer the PWCX 
archive and end this madness. If Philips doesn't want to release their code 
that's fine but there's nothing stopping us from doing it ourselves.

P.S, Philips if you do read this mailing list. You certainly didnt make many 
friends. if Adaptec can do it, you can too.

Any takers? ;-)

Shawn.


Subject:    Re: Termination of the Philips Webcam Driver (pwc)
From:       Craig Milo Rogers <rogers () isi ! edu>
Date:       2004-08-27 18:55:41
Message-ID: <20040827185541.GC24018 () isi ! edu>
[Download message RAW]

On 04.08.27, Linus Torvalds wrote:
> But Greg is right - we don't keep hooks that are there purely for binary
> drivers. If somebody wants a binary driver, it had better be a whole
> independent thing - and it won't be distributed with the kernel.

        If you read Nemosoft's final driver release (which has been
reposted, and of which I now have a copy), you can see that he was
rewriting his code to move the proprietary codecs out of the kernel
entirely, and into user-mode libraries to be linked with consenting
applications -- he was quite sensitive to the kernel issues involved.
Of course, this is still nowhere as good as a wholly open source
solution, a position with which I think Nemosoft concurs, based on his
messages.

        Linus, would you adress a moot issue, please?  If Nemosoft (or
someone else) were to release some of the codecs in question as one or
more open-source loadable kernel modules (similar to sound card
support modules in the ALSA system), while other codecs remain
binary-only loadable kernel modules (distributed outside the kernel,
but using the same hook as the open-source loadable modules), would
the pwc driver and codec extension hook be allowable, in your opinion,
please?

                                        Craig Milo Rogers
-
