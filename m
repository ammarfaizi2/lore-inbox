Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAIOYR>; Tue, 9 Jan 2001 09:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130638AbRAIOYH>; Tue, 9 Jan 2001 09:24:07 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46279 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129415AbRAIOX5>;
	Tue, 9 Jan 2001 09:23:57 -0500
Date: Tue, 9 Jan 2001 09:23:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <200101091341.HAA52016@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.GSO.4.21.0101090921560.8865-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Jesse Pollard wrote:

> Not exactly valid, since a file could be created in that "pinned" directory
> after the rmdir...

No, it couldn't (if you can show a testcase when it would - please do, you've
found a bug). Moreover, busy directories can be removed in 2.4 quite fine -
it's about pathname, not about the thing being your (or somebody else) pwd.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
