Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130879AbQKUVAH>; Tue, 21 Nov 2000 16:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131043AbQKUU75>; Tue, 21 Nov 2000 15:59:57 -0500
Received: from 213-1-125-245.btconnect.com ([213.1.125.245]:13062 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131005AbQKUU7w>;
	Tue, 21 Nov 2000 15:59:52 -0500
Date: Tue, 21 Nov 2000 20:31:37 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Jes Sorensen <jes@linuxcare.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: deadlock on 4way machine
In-Reply-To: <d3snol9jcu.fsf@lxplus015.cern.ch>
Message-ID: <Pine.LNX.4.21.0011212029260.1540-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 2000, Jes Sorensen wrote:

> >>>>> "Tigran" == Tigran Aivazian <tigran@veritas.com> writes:
> 
> Tigran> Hi, Some processes get stuck in page fault handler for ages
> Tigran> (like for 10 minutes!). The machine still has plenty (3.5G) of
> Tigran> free high memory but zero (2216K) of free low memory.
> 
> Including info on the kernel version would kinda help.

that is obtainable by fingering @finger.kernel.org (I only ever use/report
bugs on the latest kernel).

> 
> Could you also try to reproduce it without including any binary only
> proprietary kernel modules?
> 

that is the tricky question -- i.e. the bugs do not point to those modules
but I need them to produce enough stress on the MM and io subsystem to
trigger the bugs (but then again, I may be wrong and the bugs _do_ point
to those). But yes, I understand this concern and try to reproduce it on
as clean/plain kernel as possible.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
