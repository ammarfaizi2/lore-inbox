Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276244AbRJBSeK>; Tue, 2 Oct 2001 14:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276160AbRJBSeA>; Tue, 2 Oct 2001 14:34:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49929 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276120AbRJBSdt>; Tue, 2 Oct 2001 14:33:49 -0400
Subject: Re: 2.4.10 hangs on console switch
To: larsch@cs.auc.dk (Lars Christensen)
Date: Tue, 2 Oct 2001 19:39:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0110022019330.12401-100000@mega.cs.auc.dk> from "Lars Christensen" at Oct 02, 2001 08:21:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oURs-0005XB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You are using the Nvidia drivers aren't you. They seem to have timing
> > dependant screen mode switch problems. The timing has changed in 2.4.10
> 
> Not the nvidia supplied drivers. I am using the nvidia driver (nv)  that
> comes with XFree86 4.1.0. I did not compile in kernel agpgart and driver
> support.

I'm seeing  reports of this one always with nvidia cards and with both sets
of Nvidia drivers - I guess they both do the same thing and have the same
bug, or the user mode XFree bit is in both cases doing it.

Right now thats all I can really point at as a pattern, I dont know why the
problem should be there

Alan
