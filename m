Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318414AbSHEMVd>; Mon, 5 Aug 2002 08:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318415AbSHEMVd>; Mon, 5 Aug 2002 08:21:33 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:25291 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S318414AbSHEMVc>; Mon, 5 Aug 2002 08:21:32 -0400
Message-Id: <200208051225.g75CP4v316564@pimout4-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
       Patrick Mochel <mochel@osdl.org>, Adam Belay <ambx1@netscape.net>
Subject: Re: [PATCH] integrate driverfs and devfs (2.5.28)
Date: Mon, 5 Aug 2002 02:26:35 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207291431381.22697-100000@cherise.pdx.osdl.net> <200207292326.g6TNQcI19062@fachschaft.cup.uni-muenchen.de>
In-Reply-To: <200207292326.g6TNQcI19062@fachschaft.cup.uni-muenchen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 07:25 pm, Oliver Neukum wrote:
> Am Dienstag, 30. Juli 2002 00:21 schrieb Patrick Mochel:
> > 1) devfs imposes a default naming policy. That is bad, wrong and unjust.
> > There shalt not be a default naming policy in the kernel. Period.
>
> Why not? Who really needs the ability to name anything in /dev ?
> You can always use a symlink if you realy, realy want.

Okay, I'll bite.

So what's root_dev_names in init/do_mounts.c?  If a default naming policy is 
so unacceptably evil, is that being removed in 2.5 and everybody being told 
to use major/minor for the root device?

By the way, why doesn't imposing consistent predefined major/minor numbers 
(0x0301 instead of "hda1") count as "policy"?   I'm honestly curious...

Rob
