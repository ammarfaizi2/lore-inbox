Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUGIQiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUGIQiG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 12:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbUGIQiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 12:38:06 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:38575 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S265065AbUGIQh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 12:37:59 -0400
Message-ID: <40EEC9DC.8080501@tlinx.org>
Date: Fri, 09 Jul 2004 09:37:48 -0700
From: L A Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a feature! :-)

It's been in the code for years to randomly write nulls to some files 
that have been
modified in the past few days after a bad shutdown.  Reported on XFS 
list and got same
overwhelming response there. 

Apparently not easily reproduced, no one has a clue why it does it.  
Just does. 
Even after multiple syncs, files edited within the past few days
will sometimes go mysteriously null.  Good reason to do daily backups as the
backups will usually contain the correct file...

Now if we could just come up with a reproducable test case...but when I
try to reproduce it, it doesn't.  Grrr....it knows when I'm 
scrutinizing!! :-)

-l

Norberto Bensa wrote:

>Hello,
>
>how do I setup XFS to not null files after a bad shutdown?
>
>Thanks,
>Norberto
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
