Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131956AbRBOBFa>; Wed, 14 Feb 2001 20:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132007AbRBOBFU>; Wed, 14 Feb 2001 20:05:20 -0500
Received: from viper.haque.net ([64.0.249.226]:35469 "EHLO viper.haque.net")
	by vger.kernel.org with ESMTP id <S131956AbRBOBFN>;
	Wed, 14 Feb 2001 20:05:13 -0500
Message-ID: <3A8B2B46.7547FF2F@haque.net>
Date: Wed, 14 Feb 2001 20:05:10 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: modules_install target
In-Reply-To: <20010215013846.A25812@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're forgetting it's using System.map from your build directory and
not from /boot.

"J . A . Magallon" wrote:
> 
> I have recently noticed that 'make modules_install' tries as a last step
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.1-ac13; fi
> 
> I depends on 'make install' doing the right symlinks in /boot.
> Would not be better to do a:
> 
> if [ -r System.map-2.4.1-ac13 ]; then /sbin/depmod -ae -F System.map-2.4.1-ac13
>  2.4.1-ac13; fi
> 
> ???

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
