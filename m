Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTDTPEC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 11:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbTDTPEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 11:04:01 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:14464 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263597AbTDTPEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 11:04:01 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304201519.h3KFJ257000440@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: 76306.1226@compuserve.com (Chuck Ebbert)
Date: Sun, 20 Apr 2003 16:19:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <200304201108_MC3-1-3533-D395@compuserve.com> from "Chuck Ebbert" at Apr 20, 2003 11:06:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Buy IDE disks in pairs use md1, and remember to continually send the
> > hosed ones back to the vendor/shop (and if they keep appearing DOA to
> > your local trading standards/fair trading type bodies).
> 
> 
>   I buy three drives at a time so I have a matching spare, because AFAIC
> you shouldn't be doing RAID on unmatched drives.

Err, yes you should :-).

Unless they are spindle syncronised, the advantage of identical
physical layout diminishes, and the disadvantage of quite possibly
getting components from the same, (faulty), batch increases :-).

>   Using RAID1 is especially important when using software instead
> of hardware for fault-tolerance because the software is more likely to
> have bugs just because of the 'culture' of hardware vs. software
> developers, and the RAID5 algorithm is very hard to get right anyway,
> especially in failure/rebuild mode.  Even on a hardware controller
> RAID5 is still inherently less reliable.

The advantage of RAID1 over a SLED is probably greater than the
advantage of RAID5 over RAID1.

>  (...and what's all this about unreliable drives, anyway?  Every drive
> I have bought since 1987 still works.)

I haven't had a drive failiure for a long time.  Maybe I'm just really
lucky.

John.
