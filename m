Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVBYAvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVBYAvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVBYAvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:51:06 -0500
Received: from smtpout.mac.com ([17.250.248.85]:9970 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262558AbVBYArc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:47:32 -0500
In-Reply-To: <20050224150026.69b1862f.akpm@osdl.org>
References: <20050223230639.GA33795@calma.pair.com> <20050223183634.31869fa6.akpm@osdl.org> <20050224052630.GA99960@calma.pair.com> <421DD5CC.5060106@aitel.hist.no> <20050224173356.GA11593@calma.pair.com> <20050224150026.69b1862f.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CBB3F03F-86C6-11D9-931F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org,
       "Chad N. Tindel" <chad@tindel.net>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Xterm Hangs - Possible scheduler defect?
Date: Thu, 24 Feb 2005 19:47:16 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 24, 2005, at 18:00, Andrew Morton wrote:
> Here's a quicky which will convert all your kernel threads to SCHED_RR,
> priority 99.  Please test.

We have a bunch of workstations here where we run a similar thing 
during boot,
as well as starting a SCHED_RR @ 99 sulogin-type process on tty12.  It 
makes
blasting the occasional annoying fork-bomb or CPU-chewing-crashed-X a 
lot
nicer.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


