Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268079AbRGVWLX>; Sun, 22 Jul 2001 18:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268081AbRGVWLN>; Sun, 22 Jul 2001 18:11:13 -0400
Received: from [194.213.32.142] ([194.213.32.142]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S268079AbRGVWLI>;
	Sun, 22 Jul 2001 18:11:08 -0400
Date: Thu, 19 Jul 2001 18:24:07 +0000
From: Pavel Machek <pavel@suse.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Craig Soules <soules@happyplace.pdl.cmu.edu>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
Message-ID: <20010719182405.A35@toy.ucw.cz>
In-Reply-To: <Pine.LNX.3.96L.1010717180713.13980K-100000@happyplace.pdl.cmu.edu> <3B54BA7A.42B0E107@namesys.com> <20010718100037.A18393@cs.cmu.edu> <3B55A12C.F194DAF6@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B55A12C.F194DAF6@namesys.com>; from reiser@namesys.com on Wed, Jul 18, 2001 at 06:46:04PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

> > In any case, what happens if the file was renamed or removed between the
> > 2 readdir calls. A cookie identifying a name that was returned last, or
> > should be read next is just as volatile as a cookie that contains an
> > offset into the directory.
> 
> No, if the file was removed, it still tells you where to start your search.  A missing filename is
> just as good a marker as a present one.

And if new file is created with same name?
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

