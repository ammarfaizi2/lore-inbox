Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311199AbSCLOiW>; Tue, 12 Mar 2002 09:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311221AbSCLOiM>; Tue, 12 Mar 2002 09:38:12 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:27821 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311199AbSCLOh7>; Tue, 12 Mar 2002 09:37:59 -0500
Date: Tue, 12 Mar 2002 16:21:52 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: ide timer trbl ...
In-Reply-To: <E16kWS8-0001f5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0203121550320.32078-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Alan Cox wrote:

> In all the command cases thats because the previous command state has
> completed. I'm pretty sure there is one path alone wrong and its in the 
> WIP DMA timeout stuff

I don't know if you guys have come across the ide timer added twice 
problem personally, but its pretty easy to reproduce by dropping the 
device from DMA to PIO. 100% reproducible over here with my ide cdrom.

Regards,
	Zwane

