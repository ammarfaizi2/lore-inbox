Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSK0Lp2>; Wed, 27 Nov 2002 06:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSK0Lp2>; Wed, 27 Nov 2002 06:45:28 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:61312 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262324AbSK0Lp2>; Wed, 27 Nov 2002 06:45:28 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211271152.gARBqXI09379@devserv.devel.redhat.com>
Subject: Re: 2.4.20-rc4-ac1 SiS IDE driver troubles
To: murrayr@brain.org (Murray J. Root)
Date: Wed, 27 Nov 2002 06:52:32 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <20021127030633.GA1642@Master.Wizards> from "Murray J. Root" at Nov 26, 2002 10:06:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After booting and initscripts I get some kind of error like a BUG() but
> I can't see what it is because it scrolls off with repeated "unable to
> handle kernel paging request" messages. The first error shows a stack trace
> (briefly) but all the rest just show the offsets without the text.

Stick a while(1); at the end of the stack dump code and you should get
jus tthe first oops you can read
