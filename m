Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbUAFP1o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUAFP1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:27:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:14773 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264539AbUAFP1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:27:43 -0500
Date: Tue, 6 Jan 2004 07:27:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@colin2.muc.de>
cc: Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <20040106094442.GB44540@colin2.muc.de>
Message-ID: <Pine.LNX.4.58.0401060726450.2653@home.osdl.org>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de>
 <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de>
 <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, Andi Kleen wrote:
> 
> In my opinion it would have been cleaner if the aperture had always
> an reserved entry in the e820 map.

That does sound like a bug in the AGP drivers. It shouldn't be hard at all 
to make them reserve their aperture.

Hint hint.

		Linus
