Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318274AbSHEAbb>; Sun, 4 Aug 2002 20:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318275AbSHEAbb>; Sun, 4 Aug 2002 20:31:31 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:30989
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S318274AbSHEAb3>; Sun, 4 Aug 2002 20:31:29 -0400
Subject: Re: 2.4.19: no DMA for IDE with Intel i845e
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1028512143.15495.45.camel@irongate.swansea.linux.org.uk>
References: <1028505657.1545.3.camel@ixodes.goop.org> 
	<1028512143.15495.45.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Aug 2002 17:35:03 -0700
Message-Id: <1028507703.1486.11.camel@ixodes.goop.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 18:49, Alan Cox wrote:
    On Mon, 2002-08-05 at 01:00, Jeremy Fitzhardinge wrote:
    > I just rebooted with 2.4.19, and I find that there's no DMA on my ide
    > interface, and it is refusing to honour 'hdparm -d1 /dev/hda'. 
    
    I'm slowly working through fixing the new BIOS behaviour. For your case
    2.4.19-ac1 ought to do the job. 2.4.19-ac2 fixed it but has some rather
    dramatic side effects. 2.4.19-ac3 is a more invasive but more correct
    proposed answer..
    
    
    
-ac1 seems to work, but I don't really understand how.  I've looked
through the drivers/ide and arch/i386 changes, but I don't see what
makes the difference.

	J


