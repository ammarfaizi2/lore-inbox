Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVE3SLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVE3SLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVE3SLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:11:05 -0400
Received: from smtpout.mac.com ([17.250.248.86]:33516 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261666AbVE3SH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:07:58 -0400
In-Reply-To: <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
References: <1117291619.9665.6.camel@localhost> <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org> <84144f0205052911202863ecd5@mail.gmail.com> <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org> <1117399764.9619.12.camel@localhost> <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org> <1117466611.9323.6.camel@localhost> <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FC5325FE-7730-4A66-BDA8-B6C035E6276F@mac.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
Date: Mon, 30 May 2005 14:07:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2005, at 13:31:07, Linus Torvalds wrote:
> On Mon, 30 May 2005, Pekka Enberg wrote:
>> It is not just X. Running the following shell script when hitting the
>> bug:
>
> Ok, this implies that the scheduler is really screwed up, we're not
> scheduling anything else during that time.

If X is hung and not accepting data on any of its sockets, then this
could hang the Xterm in the background, and therefore hang the printout
from the "date" process.  What happens if you do this?

Switch to VT 1:
# while true; do date; sleep 1; done

Switch to X and trigger hang

Switch back to VT 1 and look at output

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



