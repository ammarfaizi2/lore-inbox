Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUJVUyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUJVUyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUJVUyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:54:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55237 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267745AbUJVUwJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:52:09 -0400
Message-ID: <417972EC.9020003@pobox.com>
Date: Fri, 22 Oct 2004 16:51:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <4177DF15.8010007@techsource.com> <4177E50F.9030702@sover.net> <200410220238.13071.jk-lkml@sci.fi> <41793C94.3050909@techsource.com> <417955D3.5020206@pobox.com> <41795DEA.8050309@techsource.com> <41796083.9060301@pobox.com> <417965E7.8010408@techsource.com>
In-Reply-To: <417965E7.8010408@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> Ok, let me say this:  I will not change something I don't have to 
> change, but I'm not going to be held back (and hold everyone else back) 
> by some mistake I made in the past.

Oh, I do agree w/ this.

But if the OS<->hardware interface is kept simple (e.g. simple DMA ring 
of items to execute, or just xfer to video RAM, and perhaps another 
response msg ring) then the impact of any design changes you -do- make 
are mitigated, and the OS driver is kept small and simple as well.

	Jeff


