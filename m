Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276703AbRJBVcn>; Tue, 2 Oct 2001 17:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276704AbRJBVcd>; Tue, 2 Oct 2001 17:32:33 -0400
Received: from pop.digitalme.com ([193.97.97.75]:39442 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S276703AbRJBVcY>;
	Tue, 2 Oct 2001 17:32:24 -0400
Subject: Re: 2.4.10 hangs on console switch
From: "Trever L. Adams" <vichu@digitalme.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lars Christensen <larsch@cs.auc.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E15oTXp-0005Mk-00@the-village.bc.nu>
In-Reply-To: <E15oTXp-0005Mk-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.30.08.08 (Preview Release)
Date: 02 Oct 2001 17:31:29 -0400
Message-Id: <1002058294.975.4.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-02 at 13:41, Alan Cox wrote:
> > Problem: Kernel 2.4.10 hangs when console is switched from X to text mode,
> > either using C-A-Fn or when shutting down or reboot from X (with a black
> > screen). 2.4.9 does not have this problem.
> > 
> > There is nothing about the hang in the log files. Kernel is configured for
> > Athlon/K7 processor.
> 
> You are using the Nvidia drivers aren't you. They seem to have timing
> dependant screen mode switch problems. The timing has changed in 2.4.10
> 
> Alan

I have an old Leadtek Winfast something or other (8MB Permedia 2).  I
see hangs on idle (saw someone point that to a conflict in 2.4.10 in apm
and the IO-APIC or something like that), shut down (when X exits) or on
console switch.  These do not happen all the time, but they are there.

Just another data point.

RedHat 7.1 up-to-date with Ximian's Gnome.

Trever

