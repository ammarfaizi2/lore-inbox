Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRAYRCT>; Thu, 25 Jan 2001 12:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130188AbRAYRCK>; Thu, 25 Jan 2001 12:02:10 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:43017 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129175AbRAYRB7>; Thu, 25 Jan 2001 12:01:59 -0500
Date: Thu, 25 Jan 2001 12:07:08 -0500
From: Chris Mason <mason@suse.com>
To: Ondrej Sury <ondrej@globe.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre10 slowdown at boot.
Message-ID: <118870000.980442428@tiny>
In-Reply-To: <87k87jzjlt.fsf@ondrej.office.globe.cz>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, January 25, 2001 05:23:26 PM +0100 Ondrej Sury
<ondrej@globe.cz> wrote:

> 
> 2.4.1-pre10 slows down after printing those (maybe ACPI or reiserfs
> issue), and even SysRQ-(s,u,b) is not imediate and waits several (two+)
> seconds before (syncing,remounting,booting).
> 
> ACPI: System description tables found
> ACPI: System description tables loaded
> ACPI: Subsystem enabled
> ACPI: System firmware supports: C2
> ACPI: System firmware supports: S0 S1 S4 S5
> reiserfs: checking transaction log (device 03:04) ...
> Warning, log replay starting on readonly filesystem
> 

Here, reiserfs is telling you that it has started replaying transactions in
the log.  You should also have a reiserfs message telling you how many
transactions it replayed, and how long it took.  Do you have that message?

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
