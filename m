Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131535AbRAGAnV>; Sat, 6 Jan 2001 19:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131823AbRAGAnM>; Sat, 6 Jan 2001 19:43:12 -0500
Received: from host97.207-55-127.aadsl.com ([207.55.127.97]:59803 "EHLO
	mullein.org") by vger.kernel.org with ESMTP id <S131535AbRAGAnC>;
	Sat, 6 Jan 2001 19:43:02 -0500
From: mull <mullein@mullein.org>
Date: Sat, 6 Jan 2001 16:43:03 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: SCSI hangs with aic7xxx in 2.4.0 SMP
Message-ID: <20010106164303.A2834@mullein.org>
In-Reply-To: <LAW2-F36Pf3L9BGTuAy0000c9e8@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <LAW2-F36Pf3L9BGTuAy0000c9e8@hotmail.com>; from ello@hotmail.com on Sat, Jan 06, 2001 at 09:26:55PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 09:26:55PM -0000, Craig Freeze wrote:
> [1.] One line summary of the problem:
> SCSI hangs with aic7xxx in 2.4.0 SMP
> 
> [2.] Full description of the problem/report:
> SCSI device errors and bus resets observed in 2.4.0 that do not occur in 
> 2.2.13.  Sysrq keys have no effect (ie hard reset required to recover)
> 
I've noticed pretty much the same situation on my uniproc box, aic7xxx driver, adaptec 2940uw card since going to 2.4.0-prerelease. haven't had to hard reset, but have seen a LOT of scsi timeout errors. i did not notice this on 2.4.0-test12 or test13pre2. when i'm at home i'll see if i can find any pattern or more info, and also test with 2.4.0 final.
mullein
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
