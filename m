Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130826AbQKCQ4K>; Fri, 3 Nov 2000 11:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130844AbQKCQ4A>; Fri, 3 Nov 2000 11:56:00 -0500
Received: from Cantor.suse.de ([194.112.123.193]:25092 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130826AbQKCQzt>;
	Fri, 3 Nov 2000 11:55:49 -0500
Date: Fri, 3 Nov 2000 17:55:46 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
Message-ID: <20001103175546.A963@gruyere.muc.suse.de>
In-Reply-To: <200011031509.eA3F9V719729@trampoline.thunk.org> <E13rj9s-0003c4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13rj9s-0003c4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Nov 03, 2000 at 03:53:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >      * Spin doing ioctls on a down netdeice as it unloads == BOOM
> >        (prumpf, Alan Cox) Possible other net driver SMP issues (andi
> >        kleen)
> 
> Turns out to be safe according to Jeff and ANK

It is not safe, just not worse than 2.2.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
