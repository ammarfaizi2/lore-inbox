Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272585AbTHFWcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272623AbTHFWcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:32:41 -0400
Received: from s4.uklinux.net ([80.84.72.14]:676 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S272585AbTHFWca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:32:30 -0400
Date: Wed, 6 Aug 2003 23:32:26 +0100 (BST)
From: Peter Denison <lkml@marshadder.uklinux.net>
X-X-Sender: peterd@marshall.localnet
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.4.21 USB printer failure w/ HP PSC750
In-Reply-To: <Pine.LNX.4.44L0.0308061619120.1249-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.44.0308062246270.807-100000@marshall.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, Alan Stern wrote:

> On Wed, 6 Aug 2003, Peter Denison wrote:
>
> > kernel:   2: [d66d9060] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1
> >  EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
>
> This indicates more communications problems.  Have you checked that your
> USB cable is okay?  Did you go back to 2.4.20 to see if that still works?

Thanks for the detailed explanation. I am still trying to verify what
happens in 2.4.20. Unfortunately, in upgrading/installing the graphics
drivers to enable me to run 2.4.21, I am now unable to run X under 2.4.20.
I have a different graphics card on order.

Simple text printing (/etc/group, print size 1024 bytes) works under both
2.4.20 and 2.4.21, as does tiger.ps (print size ~31k), so I think it
unlikely that a cable problem is to blame, but I can't yet easily test a
large, complicated rendered graphic print on 2.4.20.

However, several reboots later, the original page is printing under
2.4.21, so I don't know now if there's a problem or not.

-- 
Peter Denison <peterd at marshadder dot uklinux dot net>
Please use this address only for personal mail, not copied to lists
gatewayed to news or web pages unless the addresses are removed.


