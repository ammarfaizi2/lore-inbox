Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263161AbSJBQuT>; Wed, 2 Oct 2002 12:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263166AbSJBQuT>; Wed, 2 Oct 2002 12:50:19 -0400
Received: from 62-190-202-92.pdu.pipex.net ([62.190.202.92]:26890 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263161AbSJBQuR>; Wed, 2 Oct 2002 12:50:17 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210021703.g92H3sa7000956@darkstar.example.net>
Subject: Re: [PATCH] Bodge up serial support in 2.5.40
To: devilkin-lkml@blindguardian.org (DevilKin)
Date: Wed, 2 Oct 2002 18:03:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210021842.01673.devilkin-lkml@blindguardian.org> from "DevilKin" at Oct 02, 2002 06:42:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Standard 8250/16550 UART support is broken in 2.5.40, and I needed it,
> > > > so following a bit of advice from Russell King, I've prepared this
> > > > patch.
> > >
> > > Actually, they work fine in 2.5.40. Well, my serial mouse works fine. So
> > > i guess the serial port must work fine too.
> >
> > Hmmm, that's odd, do you not have proc enabled?  I think that it only
> > breaks if you have proc enabled, which I assumed most people do? 
> > Strange...
> 
> No, proc FS is enabled here.

Really weird, I couldn't get it to compile, it kept failing:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0209.3/1906.html

John.
