Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262021AbREXSWh>; Thu, 24 May 2001 14:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262031AbREXSW1>; Thu, 24 May 2001 14:22:27 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:37722
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S262021AbREXSWY>; Thu, 24 May 2001 14:22:24 -0400
Date: Thu, 24 May 2001 20:22:15 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/others
Message-ID: <20010524202215.A845@jaquet.dk>
In-Reply-To: <E152w81-00053C-00@the-village.bc.nu> <p05100304b732e04cf9aa@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p05100304b732e04cf9aa@[207.213.214.37]>; from jlundell@pobox.com on Thu, May 24, 2001 at 09:00:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 09:00:20AM -0700, Jonathan Lundell wrote:
[...]
> 
> Fine. But:
> 
> At 3:02 AM +0200 2001-05-24, Andrzej Krzysztofowicz wrote:
> >-	printk(version);
> >+#ifdef MODULE
> >+	printk("s", version);
> >  	printed_version = 1;
> >+#endif /* MODULE */
> 
> ...is playing it just a little too safe, wouldn't you say?

With the above snippet of code being remailed a couple of times
somebody surely noticed before me that the printk should have
"%s" as format string, not "s". But then again somebody might
not so there you are.
-- 
        Rasmus(rasmus@jaquet.dk)

"A statesman... is a dead politician. Lord knows, we need more statesmen." 
   -- Bloom County
