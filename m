Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266067AbRGSVy1>; Thu, 19 Jul 2001 17:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbRGSVyH>; Thu, 19 Jul 2001 17:54:07 -0400
Received: from teranet244-12-200.monarch.net ([24.244.12.200]:12021 "HELO
	lustre.clusterfilesystem.com") by vger.kernel.org with SMTP
	id <S266067AbRGSVyB>; Thu, 19 Jul 2001 17:54:01 -0400
Date: Thu, 19 Jul 2001 15:54:00 -0600
From: "Peter J. Braam" <braam@clusterfilesystem.com>
To: linux-kernel@vger.kernel.org
Cc: mason@suse.com, sct@redhat.com
Subject: modules/ksyms/filenames
Message-ID: <20010719155400.E27553@lustre.clusterfilesystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I'm trying to export a symbol (journal_begin/end) from
fs/reiserfs/journal.c. To export the symbols I added to the Makefile:
export-objs := journal.o

There is also a file fs/jbd/journal.c which exports symbols. 

It seems that the two journal.ver files in include/modules/*.ver get
clobbered.

Short of renaming files, is there a good solution for this? 

Thanks!

