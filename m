Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbTDEJOd (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 04:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbTDEJOd (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 04:14:33 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261482AbTDEJOd (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 04:14:33 -0500
From: John Bradford <root@81-2-122-30.bradfords.org.uk>
Message-Id: <200304050927.h359RtL2000320@81-2-122-30.bradfords.org.uk>
Subject: Re: PATCH: Fixes for ide-disk.c
To: ncunningham@clear.net.nz (Nigel Cunningham)
Date: Sat, 5 Apr 2003 10:27:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <1049527877.1865.17.camel@laptop-linux.cunninghams> from "Nigel Cunningham" at Apr 05, 2003 07:31:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> People using swsusp under 2.4 found that everything worked
> fine if they rebooted after writing the image, but powering down at the
> end of writing the image caused corruption. I got the additional check
> from the source for hdparm, which only does the new check to determine
> if a drive has a writeback cache.

Did we ever establish what the best way to ensure that the write cache is
flushed, is?  An explicit cache flush and spin down are both necessary, but
I had problems with drives spinning back up when we did the spindown first.

John.
