Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289833AbSBKPsd>; Mon, 11 Feb 2002 10:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289832AbSBKPsT>; Mon, 11 Feb 2002 10:48:19 -0500
Received: from smtp02.web.de ([217.72.192.151]:30243 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S289829AbSBKPrz>;
	Mon, 11 Feb 2002 10:47:55 -0500
To: John Weber <weber@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 Compile Error
In-Reply-To: <3C67666B.2060507@nyc.rr.com>
In-Reply-To: <3C674CFA.2030107@nyc.rr.com> <3C6750CD.46575DAA@mandrakesoft.com>  <3C675E6B.4010605@nyc.rr.com> <1013408447.806.409.camel@phantasy> <3C67666B.2060507@nyc.rr.com>
Reply-To: pharao90@tzi.de
Message-Id: <E16aIiP-0000FT-00@neptune.sol.net>
From: Pascal Schmidt <pleasure.and.pain@web.de>
Date: Mon, 11 Feb 2002 16:50:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002 07:50:06 +0100, you wrote in linux.kernel:

>  I understand the syntax, but I don't understand why one would want to 
>  return the address of something 3 longs away.  What is this function
>  supposed to be doing?

Well, from the name thread_saved_pc() it tries to get some value of PC
(the program counter ;) that's saved by that thread, right? My guess
would be that the desired value is stored on the stack at esp[3].

-- 
Ciao,
Pascal
