Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131721AbQJ2OcV>; Sun, 29 Oct 2000 09:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131726AbQJ2OcM>; Sun, 29 Oct 2000 09:32:12 -0500
Received: from slc346.modem.xmission.com ([166.70.2.92]:28946 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S131721AbQJ2OcD>; Sun, 29 Oct 2000 09:32:03 -0500
To: Raul Miller <moth@magenta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: guarantee_memory() syscall?
In-Reply-To: <972824256.eb26eb5e@magenta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Oct 2000 06:31:45 -0700
In-Reply-To: Raul Miller's message of "Sun, 29 Oct 2000 08:03:35 -0500"
Message-ID: <m1n1fn7ozi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raul Miller <moth@magenta.com> writes:

> Can anyone tell me about the viability of a guarantee_memory() syscall?
> 
> [I'm thinking: it would either kill the process, or allocate all virtual
> memory needed for its shared libraries, buffers, allocated memory, etc.
> Furthermore, it would render this process immune to the OOM killer,
> unless it allocated further memory.]

Except for the OOM killer semantics mlockall already exists.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
