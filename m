Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131113AbRBAXnL>; Thu, 1 Feb 2001 18:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131545AbRBAXnB>; Thu, 1 Feb 2001 18:43:01 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:59960 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131113AbRBAXmu>; Thu, 1 Feb 2001 18:42:50 -0500
Message-ID: <3A79F46D.24B0A201@linux.com>
Date: Thu, 01 Feb 2001 15:42:37 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: LKML <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: VM brokenness, possibly related to reiserfs
In-Reply-To: <371620000.981044164@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

> Sorry, can't seem to resolve stuph.org.  What is kreiserfsd doing during when the system is waiting for more ram?  With JOURNAL_MAX_BATCH set to 100, kreiserfsd will end up responsible for sending log blocks/metadata to disk and freeing the pinned buffers.
>
> -chris

(http://208.179.0.18/VM/)

[schedule_timeout+115/148] [process_timeout+0/72] [interruptible_sleep_on_timeout+66/92] [reiserfs_journal_commit_thread+173/224] [kernel_thread+40/56]

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
