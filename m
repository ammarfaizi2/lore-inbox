Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUCKNqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUCKNqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:46:30 -0500
Received: from furon.ujf-grenoble.fr ([152.77.2.202]:8868 "EHLO
	furon.ujf-grenoble.fr") by vger.kernel.org with ESMTP
	id S261291AbUCKNq2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:46:28 -0500
From: Mickael Marchand <marchand@kde.org>
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.4-mm1
Date: Thu, 11 Mar 2004 14:45:35 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <1ysXv-wm-11@gated-at.bofh.it> <1yxuq-6y6-13@gated-at.bofh.it> <m3hdwnawfi.fsf@averell.firstfloor.org>
In-Reply-To: <m3hdwnawfi.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403111445.35075.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 18 Mars 2004 00:25, Andi Kleen a écrit :
> Mickael Marchand <marchand@kde.org> writes:
> > [snip]
> >
> >> > while I am at it, I am running a 64 bits kernel with 32 bits debian
> >> > testing and it seems some ioctl conversion fails
> >> > that happened with all 2.6 I tried.
> >> > here is the relevant kernel messages part :
> >> > ioctl32(dmsetup:26199): Unknown cmd fd(3) cmd(c134fd00){01}
> >> > arg(0804c0b0) on /dev/mapper/control
> >>
> >> The device mapper version 1 ioctl interface was removed.  Perhaps you
> >> need to update your dm tools?
> >
> > the debian tools are built with ioctlv4 (and compat for v1)
> > I also tried with my own compiled dm tools from source without success
>
> If it just uses them for compatibility probes then the ioctl handler can
> be silenced.
hmm right now, dm/lvm absolutely does not work on amd64/32 bits. all ioctls 
calls are failling...

> >> reiserfs ioctl translation appears to be incomplete...
> >
> > ha :)
>
> I will take a look at it.
thanks

Mik
