Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTFOWNK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 18:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTFOWNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 18:13:10 -0400
Received: from 12-234-128-127.client.attbi.com ([12.234.128.127]:19414 "EHLO
	andrei.myip.org") by vger.kernel.org with ESMTP id S262912AbTFOWNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 18:13:08 -0400
Subject: Re: generic method to assign IRQs
From: Florin Andrei <florin@andrei.myip.org>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0306140035560.29854-100000@router.windsormachine.com>
References: <Pine.LNX.4.33.0306140035560.29854-100000@router.windsormachine.com>
Content-Type: text/plain
Message-Id: <1055716016.2808.33.camel@rivendell.home.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 15 Jun 2003 15:26:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-13 at 21:37, Mike Dresser wrote:
> On 13 Jun 2003, Florin Andrei wrote:
> 
> > This issue may not matter much on "normal" systems, but it matters a
> > whole bunch on multimedia machines. Not being able to untangle like five
> > or six devices assigned to the same IRQ may render an otherwise powerful
> > system totally unusable for any decent media purpose (i'm talking here
> > about simple tasks such as watching movies, not necessarily of
> > professional stuff, which is even more demanding).
> 
> Some of the problem is that motherboard manufacturers setup their hardware
> so that slots HAVE to share IRQ's no matter what you do.  I've seen
> motherboards that have shared IRQ's even if there are no cards plugged in.

I think i see what you mean.

Still, then what's the explanation for this thing: if i run a non-APIC
kernel, lots of devices are on the same IRQ. Just enable APIC in the
kernel, and change nothing else, and the busy IRQ becomes less busy.
In either case, there are tons of spare IRQs, which just sit there idle,
unused.

If the problem would be entirely in hardware, i would say APIC shouldn't
make a big difference.

Do i miss something?

-- 
Florin Andrei

http://florin.myip.org/

