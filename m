Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRDJSRf>; Tue, 10 Apr 2001 14:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131347AbRDJSRT>; Tue, 10 Apr 2001 14:17:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17415 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131191AbRDJSRJ>; Tue, 10 Apr 2001 14:17:09 -0400
Subject: Re: No 100 HZ timer !
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Tue, 10 Apr 2001 19:17:23 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka),
        ds@schleef.org (David Schleef), mbs@mc.com (Mark Salisbury),
        jdike@karaya.com (Jeff Dike), schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> from "Jamie Lokier" at Apr 10, 2001 07:35:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14n2hi-0004ma-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is an X issue. I was talking with Jim Gettys about what is needed to
> > get the relevant existing X extensions for this working
> 
> Last time I looked at XF86DGA (years ago), it seemed to have the right
> hooks in place.  Just a matter of server implementation.  My
> recollection is dusty though.

There is also a timing extension for synchronizing events to happenings. The
stopper is the kernel interface for the vblank handling since the irq must
be handled and cleared in kernel context before we return to X. We now think
we know how to handle that cleanly

Alan

