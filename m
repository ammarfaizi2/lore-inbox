Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268951AbRG0TyW>; Fri, 27 Jul 2001 15:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268947AbRG0TyJ>; Fri, 27 Jul 2001 15:54:09 -0400
Received: from congress107.linuxsymposium.org ([209.151.18.107]:38016 "EHLO
	lapdancer.baythorne.internal") by vger.kernel.org with ESMTP
	id <S268944AbRG0TyA>; Fri, 27 Jul 2001 15:54:00 -0400
Date: Sat, 28 Jul 2001 04:53:30 +0100 (BST)
From: David Woodhouse <dwmw2@infradead.org>
X-X-Sender: <dwmw2@lapdancer.baythorne.internal>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: 2.4.7-pre9..
In-Reply-To: <20010727124736.B12304@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.33.0107280451150.4428-100000@lapdancer.baythorne.internal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


(Cc list trimmed)

On Fri, 27 Jul 2001, Matthew Dharm wrote:

> IIRC, usb-storage only uses semaphores that are allocated via kfree, so I
> think we're okay.  Tho, I think the new semantics are probably better, and
> will probably switch to them.  Later.

If the exit (or indeed any) path does down(); kfree(); you suffer the same 
problem.

-- 
dwmw2

