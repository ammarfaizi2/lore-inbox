Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272525AbTGaPX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272501AbTGaPXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:23:48 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:65036 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S272543AbTGaPXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:23:11 -0400
Date: Thu, 31 Jul 2003 17:23:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Willy Tarreau <willy@w.ods.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030731152303.GA31556@alpha.home.local>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de> <20030731062252.GM1873@lug-owl.de> <20030731071719.GA26249@alpha.home.local> <20030731150758.GE6410@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731150758.GE6410@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 04:07:58PM +0100, Jamie Lokier wrote:
 
> Of course this is not a problem when "lock;cmpxchg" is used only for thread
> synchronisation on uniprocessor 386s...  The lock prefix is irrelevant then.

This is exactly what it written in configure.help ;-)

> Perhaps the emulation should refuse to pretend to work on an SMP 386 :)

I've seen such a config once. In fact, it was a board with two i376 (the 386
equivalent which does protected mode only, no M86 nor real mode). But I never
knew if they were connected to the same bus or totally independant.

Cheers,
Willy

