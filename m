Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277236AbRJDVVY>; Thu, 4 Oct 2001 17:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277234AbRJDVVO>; Thu, 4 Oct 2001 17:21:14 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:15284 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277237AbRJDVU5>; Thu, 4 Oct 2001 17:20:57 -0400
Date: 04 Oct 2001 21:28:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8ADlR04Xw-B@khms.westfalen.de>
In-Reply-To: <Pine.GSO.4.21.0110041153560.28270-100000@weyl.math.psu.edu>
Subject: Re: Security question: "Text file busy" overwriting executables but no
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.33.0110040842320.8350-100000@penguin.transmeta.com> <Pine.GSO.4.21.0110041153560.28270-100000@weyl.math.psu.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@math.psu.edu (Alexander Viro)  wrote on 04.10.01 in <Pine.GSO.4.21.0110041153560.28270-100000@weyl.math.psu.edu>:

>
> On Thu, 4 Oct 2001, Linus Torvalds wrote:
>
> >    In short, now you need filesystem versioning at a per-page level etc.
>
> *ding* *ding* *ding* we have a near winner.  Remember, folks, Hurd had been
> started by people who not only don't understand UNIX, but detest it.
> ITS/TWENEX refugees.  And semantics in question comes from there -
> they had "open and make sure that anyone who tries to modify will get
> a new version, leaving one we'd opened unchanged".

Sounds to me like it could be done ... *if* you had per-process filesystem  
snapshot capability.

Of course, that's using ICBMs to swat mosquitos. I don't recommend it just  
for implementing a mmap() flag.

MfG Kai
