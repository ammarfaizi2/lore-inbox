Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129086AbQKBRjn>; Thu, 2 Nov 2000 12:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129113AbQKBRjX>; Thu, 2 Nov 2000 12:39:23 -0500
Received: from bastion.power-x.co.uk ([62.232.19.201]:3332 "EHLO
	bastion.power-x.co.uk") by vger.kernel.org with ESMTP
	id <S129086AbQKBRjO>; Thu, 2 Nov 2000 12:39:14 -0500
Date: Thu, 2 Nov 2000 17:39:03 +0000 (GMT)
From: "Dr. David Gilbert" <dg@px.uk.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: kernel@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <Pine.LNX.4.21.0011021408040.2508-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0011021738010.24579-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Tigran Aivazian wrote:

> yes, that someone was me :) It did indeed help to my 4way 6G RAM Xeon --
> the performance improved 40x!. Also, using David's mtrr.patch helped with
> the problem of eepro100 interfaces sometimes not coming up properly (and
> generally, it is nice to see all your 6G appear in /proc/mtrr).
> 
> So, here is David's mtrr patch. Although in his case ("only" 4G) it
> shouldn't be needed.... it is for 36bit MTRRs I assume.

Thanks! That patch did the trick - our machine is now running lovely.

Thanks again,

Dave

-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
