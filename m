Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277143AbRJDGz1>; Thu, 4 Oct 2001 02:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277145AbRJDGzS>; Thu, 4 Oct 2001 02:55:18 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:12081 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S277143AbRJDGzF>; Thu, 4 Oct 2001 02:55:05 -0400
Date: Thu, 4 Oct 2001 01:55:23 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Ben Greear <greearb@candelatech.com>
cc: jamal <hadi@cyberus.ca>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBC06A1.1818E45C@candelatech.com>
Message-ID: <Pine.LNX.3.96.1011004015444.25623C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, Ben Greear wrote:
> That requires re-writing all the drivers, right?

NAPI?  no.  You move some existing code into a separate function, mainly

	Jeff



