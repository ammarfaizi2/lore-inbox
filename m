Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261507AbSIXAFs>; Mon, 23 Sep 2002 20:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261513AbSIXAFs>; Mon, 23 Sep 2002 20:05:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37125 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261507AbSIXAFr>;
	Mon, 23 Sep 2002 20:05:47 -0400
Message-ID: <3D8FAD70.2010404@pobox.com>
Date: Mon, 23 Sep 2002 20:10:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
CC: Ingo Molnar <mingo@elte.hu>, Bill Davidsen <davidsen@tmr.com>,
       Larry McVoy <lm@bitmover.com>, Peter Waechtler <pwaechtler@mac.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <Pine.LNX.3.96.1020923152135.13351C-100000@gatekeeper.tmr.com> <Pine.LNX.4.44.0209232218320.2118-100000@localhost.localdomain> <20020923190306.D13340@hexapodia.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:
> Of course this can be (and frequently is) implemented such that there is
> not one Pthreads thread per object; given simulation environments with 1
> million objects, and the current crappy state of Pthreads
> implementations, the researchers have no choice.


Are these object threads mostly active or inactive?

Regardless, it seems obvious with today's hardware, that 1 million 
objects should never be one-thread-per-object, pthreads or no.  That's 
just lazy programming.

	Jeff



