Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261948AbRE2BNb>; Mon, 28 May 2001 21:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261969AbRE2BNV>; Mon, 28 May 2001 21:13:21 -0400
Received: from viper.haque.net ([66.88.179.82]:44701 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S261948AbRE2BNC>;
	Mon, 28 May 2001 21:13:02 -0400
Message-ID: <3B12F79C.70D672E8@haque.net>
Date: Mon, 28 May 2001 21:13:00 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Plain 2.4.5 VM...
In-Reply-To: <3B12EE32.9B35F89F@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Ouch!  When compiling MySql, building sql_yacc.cc results in a ~300M
> cc1plus process size.  Unfortunately this leads the machine with 380M of
> RAM deeply into swap:
> 
> Mem:   381608K av,  248504K used,  133104K free,       0K shrd,     192K
> buff
> Swap:  255608K av,  255608K used,       0K free                  215744K
> cached
> 
> Vanilla 2.4.5 VM.

I don't think this is new/unusual. 

You can add the following to configure when compiling mysql .. 

  --with-low-memory       Try to use less memory to compile to avoid 
                          memory limitations.
 
--

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
