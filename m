Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271733AbRH3JKK>; Thu, 30 Aug 2001 05:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRH3JKA>; Thu, 30 Aug 2001 05:10:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38926 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271733AbRH3JJn>; Thu, 30 Aug 2001 05:09:43 -0400
Subject: Re: Multithreaded core dumps
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 30 Aug 2001 10:12:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kmacy@netapp.com (Kip Macy),
        efeingold@mn.rr.com (Elan Feingold), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108300457270.9879-100000@weyl.math.psu.edu> from "Alexander Viro" at Aug 30, 2001 05:03:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cNsX-0000m7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The 2.4-ac tree supports dumping core.$pid for the threads that actually
> > died
> 
> ... and these dumps are not reliable.  Living thread may modify the
> contents of dump as it's being written out.  I.e. you are getting
> false alarms - inconsistent data that was never there.

That is mathematically insoluble. Think about an SMP system, you cannot stop
the other thread in instantaneously small time

Alan
