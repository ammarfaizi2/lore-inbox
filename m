Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281202AbRKTS7E>; Tue, 20 Nov 2001 13:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281225AbRKTS6x>; Tue, 20 Nov 2001 13:58:53 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:29369 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S281202AbRKTS6t>;
	Tue, 20 Nov 2001 13:58:49 -0500
Date: Tue, 20 Nov 2001 19:58:47 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: VM tuning for Linux routers
Message-ID: <20011120195847.A27711@se1.cogenit.fr>
In-Reply-To: <20011118145400.A23181@se1.cogenit.fr> <E1661at-0005cw-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1661at-0005cw-00@calista.inka.de>; from ecki@lina.inka.de on Tue, Nov 20, 2001 at 04:29:07AM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels <ecki@lina.inka.de> :
> In article <20011118145400.A23181@se1.cogenit.fr> you wrote:
> >> You can increase the reserved free memory (not sure where to do this in
> > This reserve isn't dedicated to networking alas.
> 
> But it is for atomic kernel memory requests, which happen to be caused by
> Interrupt handlers. On a Network loaded Box most of them are from the NICs.

The word "firewall" triggered the syslog activity led in my head. :o)

<grep, grep>
How would you do an estimate of the required memory for the whole 
networking (GFP_ATOMIC is wildly used out of the irq handlers themselves) ?

-- 
Ueimor 
