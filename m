Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130488AbRBOAHv>; Wed, 14 Feb 2001 19:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130962AbRBOAHm>; Wed, 14 Feb 2001 19:07:42 -0500
Received: from jalon.able.es ([212.97.163.2]:46054 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130488AbRBOAHe>;
	Wed, 14 Feb 2001 19:07:34 -0500
Date: Thu, 15 Feb 2001 01:07:26 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c 2.5.5
Message-ID: <20010215010726.G21100@werewolf.able.es>
In-Reply-To: <20010215003802.A21100@werewolf.able.es> <E14TBaF-0006TC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14TBaF-0006TC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 15, 2001 at 00:43:36 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.15 Alan Cox wrote:
> 
> The rest are revision noise and incorrect reverts of include changes
> 
> >  #ifndef MODULE
> > +#ifdef CONFIG_I2C_CHARDEV
> >  	extern int i2c_dev_init(void);
> 
> Also reverting a cleanup
> 

And I manually deleted the
#endif /* X */   (kernel)
vs
#endif X         (i2c 2.5.5)

diffs that I got...
(do not know why the maintainer did not clone the change...)

So I suppose the lm_sensors-2.5.5 package will have the same problems.
Well, I will leave it for home use...

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac10 #1 SMP Sun Feb 11 23:36:46 CET 2001 i686

