Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRIDSlL>; Tue, 4 Sep 2001 14:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbRIDSlC>; Tue, 4 Sep 2001 14:41:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:25271 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266448AbRIDSkv>; Tue, 4 Sep 2001 14:40:51 -0400
Subject: Re: [RFD] readonly/read-write semantics
To: Pavel Machek <pavel@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF2C0F5A44.F31182F2-ON87256ABD.00660195@boulder.ibm.com>
From: "Bryan Henderson" <hbryan@us.ibm.com>
Date: Tue, 4 Sep 2001 11:39:27 -0700
X-MIMETrack: Serialize by Router on D03NM088/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/04/2001 12:39:30 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Okay, make the definition
>
>"this kernel will not attempt to change anything on that filesystem".

Not quite.  As mentioned a little earlier, you need to add "through this
mount."  It's a state of the mount, not the kernel image.

It's a good point, though, that we shouldn't kid ourselves that having a
mount in read-only state means the filesystem is read-only.  In the cases
where it does, though, it's an especially useful state.




