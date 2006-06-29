Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWF2Ujp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWF2Ujp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWF2Ujp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:39:45 -0400
Received: from mail.charite.de ([160.45.207.131]:28647 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932445AbWF2Ujo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:39:44 -0400
Date: Thu, 29 Jun 2006 22:39:42 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm one process gets stuck in infinite loop in the kernel.
Message-ID: <20060629203942.GE20456@charite.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Helge Hafting <helge.hafting@aitel.hist.no>,
	linux-kernel@vger.kernel.org
References: <20060629013643.4b47e8bd.akpm@osdl.org> <44A3B8A0.4070601@aitel.hist.no> <20060629104117.e96df3da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060629104117.e96df3da.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:

> > I have seen this both with mm2, m33 and mm4.
> > Suddenly, the load meter jumps.
> > Using ps & top, I see one process using 100% cpu.
> > This is always a process that was exiting, this tend to happen
> > when I close applications, or doing debian upgrades which
> > runs lots of short-lived processes.
> > 
> > I believe it is running in the kernel, ps lists it with stat "RN"
> > and it cannot be killed, not even with kill -9 from root.

I see exactly the same here.

> Please generate a kernel profile when it happens so we can see
> where it got stuck.

Do I need to compile the kernel with profiling for this:> 
> <boot with profile=1>
to work? And is "profile=1" a boot parameter?

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
