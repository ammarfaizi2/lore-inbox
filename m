Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRAPWO0>; Tue, 16 Jan 2001 17:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131383AbRAPWOQ>; Tue, 16 Jan 2001 17:14:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30735 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130105AbRAPWOE>;
	Tue, 16 Jan 2001 17:14:04 -0500
Date: Tue, 16 Jan 2001 22:13:57 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: super_operations in -pre7
Message-ID: <20010116221357.H20275@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


several new operations have been added to super_operations, presumably
as part of the reiserfs merge.  write_super_lockfs and unlockfs are
never called.  can we remove them?

-- 
Revolutions do not require corporate support.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
