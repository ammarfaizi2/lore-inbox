Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280679AbRKFXSS>; Tue, 6 Nov 2001 18:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280671AbRKFXSN>; Tue, 6 Nov 2001 18:18:13 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64920 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280683AbRKFXRR>;
	Tue, 6 Nov 2001 18:17:17 -0500
Date: Tue, 6 Nov 2001 18:17:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stephen Tweedie <sct@redhat.com>
cc: ext2-devel@lists.sourceforge.net, m@mo.optusnet.com.au,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrew Morton <akpm@zip.com.au>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: ext2/ialloc.c cleanup
In-Reply-To: <20011106214821.N4137@redhat.com>
Message-ID: <Pine.GSO.4.21.0111061808440.29465-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, promised cleanup of ialloc.c is on
ftp.math.psu.edu:pub/viro/ialloc.c,v

And yes, it's in RCS.  The thing is split into _really_ small
steps (commented in the log).  Each is a trivial transformation
and it should be very easy to verify correctness of any of
them.

Please, review.  IMO it's cut fine enough to make the gradual merge
possible for 2.4 - look and you'll see.


