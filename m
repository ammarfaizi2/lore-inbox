Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTLJA5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 19:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTLJA5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 19:57:05 -0500
Received: from mxsf16.cluster1.charter.net ([209.225.28.216]:27654 "EHLO
	mxsf16.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262580AbTLJA5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 19:57:02 -0500
Date: Tue, 9 Dec 2003 19:51:54 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: merged in bk5 Re: Catching NForce2 lockup with NMI watchdog - found?
Message-ID: <20031210005154.GA18974@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3FD65347.6060109@netzentry.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD65347.6060109@netzentry.com>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test11-Jm-nf2 i686
X-Uptime: 19:43:29 up 3 days, 16:10,  6 users,  load average: 1.00, 1.00, 1.00
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Tue, Dec 09, 2003 at 02:57:11PM -0800, b@netzentry.com wrote:
> Is this stuff going to be merged into 2.4 soon? I'd like
> to try a 2.4.23/24-bk with these patches.
> 

These patches are extremely simple.  If they don't patch cleanly just
edit the files directly.  The first one is 2 lines and the second adds
17 lines.

> 
> >From: Bob
> >Subject: merged in bk5 Re: Catching NForce2 lockup with NMI
> >
> >if you're following this thread, good news--
> >
> >nforce2 fixups have been merged in
> >linux-2.6.0-test11-bk5.patch
> >>  -bk snapshot (patch-2.6.0-test11-bk5)
> >
> >nforce2-disconnect-quirk.patch
> >>  [x86] fix lockups with APIC support on nForce2
> >>
> >>nforce2-apic.patch
> >>  [x86] do not wrongly override mp_ExtINT IRQ
> >
> >plus promise and sis fixes so I don't need to pay
> >for a 3ware controller ;-)   that was another
> >show-stopper for me earlier
> >
> >> We're all trying to get acpi, apic, lapic, io-apic working
> >> when turned on in cmos/bios and kernel.
> >>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
