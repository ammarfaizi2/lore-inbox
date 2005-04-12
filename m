Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVDLGfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVDLGfv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVDLGfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:35:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:38812 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262010AbVDLGfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 02:35:43 -0400
Subject: Re: 2.6.12-rc2-mm3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <87u0mc8v2p.fsf@blackdown.de>
References: <20050411012532.58593bc1.akpm@osdl.org>
	 <87wtr8rdvu.fsf@blackdown.de> <1113276365.5387.39.camel@gaston>
	 <87u0mc8v2p.fsf@blackdown.de>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 16:34:16 +1000
Message-Id: <1113287657.5387.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 06:42 +0200, Juergen Kreileder wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Tue, 2005-04-12 at 03:18 +0200, Juergen Kreileder wrote:
> >> Andrew Morton <akpm@osdl.org> writes:
> >>
> >>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> >>
> >> I'm getting frequent lockups on my PowerMac G5 with rc2-mm3.
> >>
> >> 2.6.11-mm4 works fine but all 2.6.12 versions I've tried (all since
> >> -rc1-mm3) lock up randomly.  The easiest way to reproduce the
> >> problem seems to be running Azareus.  So it might be network
> >> related, but I'm not 100% sure about that, there was a least one
> >> deadlock with virtually no network usage.
> >
> > Hrm... I just noticed you have CONFIG_PREEMPT enabled... Can you
> > test without it and let me know if it makes a difference ?
> 
> IIRC I had disabled that for rc2-mm2 and it didn't make a difference.
> I'll disable it again when I try older versions.
> 
> I just got another crash with rc2-mm3.  The crash was a bit different
> this time, I still could move the mouse pointer and the logs contained
> some info:

Ok, what about non-mm  ? (just plain rc2)

Ben.


