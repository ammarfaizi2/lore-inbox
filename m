Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131299AbRCHIp5>; Thu, 8 Mar 2001 03:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131298AbRCHIpr>; Thu, 8 Mar 2001 03:45:47 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2564 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131295AbRCHIpd>;
	Thu, 8 Mar 2001 03:45:33 -0500
Date: Wed, 7 Mar 2001 18:17:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alexander Viro <viro@math.psu.edu>, Jeremy Elson <jelson@circlemud.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another?
Message-ID: <20010307181722.E55@(none)>
In-Reply-To: <Pine.GSO.4.21.0103070051060.2127-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0103070301310.1548-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0103070301310.1548-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Mar 07, 2001 at 03:02:14AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You are reinventing the wheel.
> > man ptrace (see PTRACE_{PEEK,POKE}{TEXT,DATA} and PTRACE_{ATTACH,CONT,DETACH})
> 
> With ptrace data will be copied twice. As far as I understood, Jeremy
> wants to avoid that. 

mmap /proc/pid/memory?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

