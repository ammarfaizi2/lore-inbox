Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKMQAb>; Mon, 13 Nov 2000 11:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129918AbQKMQAV>; Mon, 13 Nov 2000 11:00:21 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25606 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129044AbQKMQAM>;
	Mon, 13 Nov 2000 11:00:12 -0500
Message-ID: <3A101009.5F05DA18@mandrakesoft.com>
Date: Mon, 13 Nov 2000 11:00:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven_Snyder@3com.com
CC: linux-kernel@vger.kernel.org
Subject: Re: State of Posix compliance in v2.2/v2.4 kernel?
In-Reply-To: <88256996.00577D9E.00@hqoutbound.ops.3com.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven_Snyder@3com.com wrote:
> Sorry if this is a FAQ, but I've searched the archives for this list
> (http://www.uwsg.iu.edu/hypermail/linux/kernel/) and only come with references
> from 1996!
> 
> What is the state of Posix-compliant services (threads, semaphores, timers,
> etc.) in the current (v2.2/v2.4) Linux kernels?

IMHO this is a question better asked of glibc people, not kernel people.

The kernel does its best to facilitate POSIX compliances, but in some
cases the kernel developers have said "POSIX is braindead here!" and
solved a particular problem in a non-POSIX way.  [and leaves glibc to
pick up the pieces, and enforce POSIX compliancy]

Also, from what I've seen lately on IRC and lkml, the Single Unix
Specification ("SuS") is generally held in higher regard than POSIX; and
when spec questions arise, kernel developers tend to check SuS before
POSIX (if POSIX is checked at all).

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
