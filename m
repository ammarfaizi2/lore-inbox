Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282079AbRKWGu6>; Fri, 23 Nov 2001 01:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282078AbRKWGus>; Fri, 23 Nov 2001 01:50:48 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:24987 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S282076AbRKWGu3>; Fri, 23 Nov 2001 01:50:29 -0500
Date: Fri, 23 Nov 2001 08:57:19 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <pavel@suse.cz>
Cc: <macro@ds2.pg.gda.pl>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disabling FPU, MMX, SSE units?
Message-ID: <Pine.LNX.4.33.0111230847240.17123-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can't disable MMX/SSE because its used to optimise, if you don't want
to use SSE/MMX select a non-SSE/MMX cpu in the kernel config, that way
you'll lose those assembly optimisations. If you want to impare your CPU
even more (as seems the case) consider using 486 as a CPU target and perhaps also
cripple your cpu caches (ie set bit 0x1E (CD) in cr0).


Cheers,
	Zwane Mwaikambo


