Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBJWEz>; Sat, 10 Feb 2001 17:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129041AbRBJWEo>; Sat, 10 Feb 2001 17:04:44 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:24849 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S129027AbRBJWEg>; Sat, 10 Feb 2001 17:04:36 -0500
Date: Sat, 10 Feb 2001 14:04:21 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.LNX.4.21.0102101942550.2378-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.32.0102101401110.27653-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Rik , As an aside to the below conversation .
	Is there a URL/doc/... that gives basic tuning examples
	for various types workloads ?   Tia ,  JimL

On Sat, 10 Feb 2001, Rik van Riel wrote:
 ...snip...
> > It's still reluctant to shrink cache.  I'm hitting I/O saturation
> > at 20 jobs vs 30 with ac5.  (difference seems to be the delta in
> > space taken by cache.. ~same space shows as additional swap volume).
>
> Indeed, to "fix" that we'll need to work at refill_inactive().
>
> However, I am very much against tuning the VM for one particular
> workload. If you can show me that this problem also happens under
> other workloads we can work at changing it, but I don't think it's
 ...snip...
       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
