Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQKGTWh>; Tue, 7 Nov 2000 14:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129188AbQKGTW2>; Tue, 7 Nov 2000 14:22:28 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15633 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129050AbQKGTWO>;
	Tue, 7 Nov 2000 14:22:14 -0500
Message-ID: <3A085642.D4837556@mandrakesoft.com>
Date: Tue, 07 Nov 2000 14:21:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tytso@mit.edu
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <E13rj9s-0003c4-00@the-village.bc.nu> <200011072017.eA7KHcm23505@trampoline.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu wrote:
>    >      * Issue with notifiers that try to deregister themselves? (lnz;
>    >        notifier locking change by Garzik should backed out, according to
>    >        Jeff)
> 
>    and according to Alan
> 
> But it hasn't been backed out yet, correct?

It has been backed out.  Notifier register and deregister are locked,
but not notifier call.

-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
