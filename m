Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRI1IaS>; Fri, 28 Sep 2001 04:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275975AbRI1IaI>; Fri, 28 Sep 2001 04:30:08 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:59089 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S275973AbRI1IaC>;
	Fri, 28 Sep 2001 04:30:02 -0400
Date: Fri, 28 Sep 2001 10:30:12 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to debug PCI issues?
Message-ID: <20010928103012.A17549@se1.cogenit.fr>
In-Reply-To: <3BB3CFFA.F9021469@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BB3CFFA.F9021469@candelatech.com>; from greearb@candelatech.com on Thu, Sep 27, 2001 at 06:18:50PM -0700
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> :
[...]
> So, I'm thinking that the DLINK NIC must be screwing up the PCI
> bus somehow when more than one of it's interfaces is passing any
> significant traffic.  I have been able to run 10Mbps on all 8 ports
> of two DLINKs on an Intel EEA2 (i815) board, so I suspect the MB.
> 
> Does anyone have any ideas how to go about trouble-shooting this
> farther?

Check the pci latency timer settings for the devices are the same
on the two mobos and force them with setpci if they aren't.

-- 
Ueimor
