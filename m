Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130680AbRBWDE7>; Thu, 22 Feb 2001 22:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130856AbRBWDEt>; Thu, 22 Feb 2001 22:04:49 -0500
Received: from viper.haque.net ([64.0.249.226]:21376 "EHLO viper.haque.net")
	by vger.kernel.org with ESMTP id <S130609AbRBWDEp>;
	Thu, 22 Feb 2001 22:04:45 -0500
Message-ID: <3A95D346.41756D2B@haque.net>
Date: Thu, 22 Feb 2001 22:04:38 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jeff@CYTE.COM
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 seems to break loopback and/or mount
In-Reply-To: <Pine.LNX.4.21.0102221714370.1662-100000@stingray.ntcor.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loopback is broken in 2.4.2 AFAIK. You can grab the loop-6 patch and
apply it to 2.4.2 and it should work.

You should also upgrade modutils to 2.4.2 as it's required by 2.4.2 (so
says the Change file anyways).

jeff@CYTE.COM wrote:
> Any ideas as to what is wrong?
> The only thing I can think of is that my modutils is v2.3.19
> but I doubt that is doing it as the loop module and other modules
> are loaded fine.
> 
> If anybody has an idea as to what I broke please let me know.
> I will upgrade modutils tomorrow and see if the problem goes
> away while I wait for a possibly more accurate response.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
