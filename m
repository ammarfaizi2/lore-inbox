Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135208AbRDLQeR>; Thu, 12 Apr 2001 12:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135221AbRDLQd5>; Thu, 12 Apr 2001 12:33:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6302 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135208AbRDLQdr>;
	Thu, 12 Apr 2001 12:33:47 -0400
Date: Thu, 12 Apr 2001 12:33:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: [PATCH][CFT] ext2 directories in pagecache
Message-ID: <Pine.GSO.4.21.0104121217580.19944-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, IMO ext2-dir-patch got to the stable stage. Currently
it's against 2.4.4-pre2, but it should apply to anything starting with
2.4.2 or so.

	Ted, could you review it for potential inclusion into 2.4 once
it gets enough testing? It's ext2-only (the only change outside of
ext2 is exporting waitfor_one_page()), it doesn't change fs layout,
it seriously simplifies ext2/dir.c and ext2/namei.c and it gives better
VM behaviour.

	Patch is on ftp.math.psu.edu/pub/viro/ext2-dir-patch.gz

	Folks, please give it a good beating - it works here, but I'd
really like it to get wide testing. Help would be very welcome.
								Al

