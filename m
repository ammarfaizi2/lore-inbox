Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbUBZTnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbUBZTnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:43:22 -0500
Received: from eleanor.physics.ucsb.edu ([128.111.8.116]:37044 "EHLO
	eleanor.physics.ucsb.edu") by vger.kernel.org with ESMTP
	id S262801AbUBZTkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:40:01 -0500
Date: Thu, 26 Feb 2004 11:41:24 -0800 (PST)
From: David Whysong <dwhysong@physics.ucsb.edu>
To: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [resend] ioapic+shared interrupt+concurrent access=ide lockup
Message-ID: <Pine.LNX.4.33.0402261137390.23839-100000@eleanor.physics.ucsb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:
> The ide subsystem locks up on a dual Opteron system when io-apic is
> enabled and there are concurrent accesses to both ide channels of a pci
> ide controller card.
[...]

I'll confirm this, I had the same problem with a Promise 20269 controller,
Tyan S2885 motherboard, dual Opteron 240.

-- 
David Whysong                                       dwhysong@physics.ucsb.edu
Astrophysics graduate student         University of California, Santa Barbara
My public PGP keys are on my web page - http://www.physics.ucsb.edu/~dwhysong
DSS PGP Key 0x903F5BD6  :  FE78 91FE 4508 106F 7C88  1706 B792 6995 903F 5BD6
D-H PGP key 0x5DAB0F91  :  BC33 0F36 FCCD E72C 441F  663A 72ED 7FB7 5DAB 0F91

