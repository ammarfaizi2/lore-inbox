Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRBTVGb>; Tue, 20 Feb 2001 16:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130136AbRBTVGV>; Tue, 20 Feb 2001 16:06:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12038 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129791AbRBTVGR>; Tue, 20 Feb 2001 16:06:17 -0500
Subject: Re: [beta patch] SSE copy_page() / clear_page()
To: pavel@suse.cz (Pavel Machek)
Date: Tue, 20 Feb 2001 21:08:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@suse.cz (Pavel Machek),
        manfred@colorfullife.com (Manfred Spraul),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010220215216.C17159@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at Feb 20, 2001 09:52:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VK1A-0000hh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does the prefetch instruction fault on PIII/PIV then - the K7 one appears not
> > to be a source of faults
> 
> My fault. I was told that prefetch instructions are always
> non-faulting.

I also thought it was non faulting
