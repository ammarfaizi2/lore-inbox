Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130722AbQJ1P5w>; Sat, 28 Oct 2000 11:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130699AbQJ1P5n>; Sat, 28 Oct 2000 11:57:43 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:47318 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130594AbQJ1P5d>; Sat, 28 Oct 2000 11:57:33 -0400
To: James Lewis Nance <jlnance@intrex.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New VM problem
In-Reply-To: <20001027070329.A884@bessie.dyndns.org>
From: Christoph Rohland <cr@sap.com>
Date: 28 Oct 2000 17:59:24 +0200
In-Reply-To: James Lewis Nance's message of "Fri, 27 Oct 2000 07:03:29 -0400"
Message-ID: <m3lmv9x8gz.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Lewis Nance <jlnance@intrex.net> writes:

>     On an unrelated note, is it possible for a process in 2.4 to see more
> than 2G of address space?  They seem to be limited to 2G for me.  I
> was hoping that the HIMEM stuff had removed that limit.

You have 3GB user space address space. 1 GB is still reserved for the
kernel and you cannot break the 4GB limit for one process. But you can
have multiple processes using their own <3GB chunk of memory.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
