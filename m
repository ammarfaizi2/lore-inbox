Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTKOFS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 00:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTKOFS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 00:18:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17344 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261538AbTKOFS1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 00:18:27 -0500
Message-ID: <3FB5B70D.3090309@pobox.com>
Date: Sat, 15 Nov 2003 00:18:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jack Steiner <steiner@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: hot cache line due to note_interrupt()
References: <Pine.LNX.4.44.0311141015050.1861-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311141015050.1861-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The fact is, irqdebug _has_ resulted in a few reports where instead of a 
> silent and total lock-up, the kernel just said "I'll disable this irq" and 
> the machine continued limping along.


I strongly agree.

There are two huge reasons I develop and debug drivers solely in 2.6 
now: kksymoops and irqdebug.  Both have helped a great deal in tracking 
down problems.  Indeed, screaming irqs that lead to lockups are 
instantly detected in 2.6.

But hey... I'm just a developer.  Who can say whether it should be on by 
default?

	Jeff



