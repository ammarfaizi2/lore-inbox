Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLORkB>; Fri, 15 Dec 2000 12:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbQLORju>; Fri, 15 Dec 2000 12:39:50 -0500
Received: from zeus.kernel.org ([209.10.41.242]:16648 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129370AbQLORjp>;
	Fri, 15 Dec 2000 12:39:45 -0500
Date: Fri, 15 Dec 2000 17:07:25 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>, Andi Kleen <ak@muc.de>,
        Andrea Arcangeli <andrea@suse.de>, wtenhave@sybase.com,
        hdeller@redhat.com, Eric Lowe <elowe@myrile.madriver.k12.oh.us>,
        Larry Woodman <woodman@missioncriticallinux.com>, linux-mm@kvack.org
Subject: New patches for 2.2.18 raw IO (fix for fault retry)
Message-ID: <20001215170725.R11931@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

OK, this now assembles the full outstanding set of raw IO fixes for
the final 2.2.18 kernel, both with and without the 4G bigmem patches.

The only changes since the last 2.2.18pre24 release are the addition
of a minor bugfix (possible failures when retrying after getting colliding
kiobuf mappings spanning two separate process virtual memory spaces),
and the addition by popular demand of the ability to unbind raw
devices (just bind them to 0,0 to unbind).

kiobuf-2.2.18.tar.gz has been uploaded to:

	ftp.uk.linux.org:/pub/linux/sct/fs/raw-io/
and	ftp.*.kernel.org:/pub/linux/kernel/people/sct/raw-io/

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
