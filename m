Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279658AbRKAUCh>; Thu, 1 Nov 2001 15:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279657AbRKAUC2>; Thu, 1 Nov 2001 15:02:28 -0500
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:3502 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S279658AbRKAUCM>; Thu, 1 Nov 2001 15:02:12 -0500
Message-ID: <3BE1A9D5.3000508@wanadoo.fr>
Date: Thu, 01 Nov 2001 21:00:21 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Nick LeRoy <nleroy@cs.wisc.edu>
CC: Ricardo Martins <thecrown@softhome.net>, linux-kernel@vger.kernel.org
Subject: Re: on exit xterm  totally wrecks linux 2.4.11 to 2.4.14-pre6 (unkillable processes)
In-Reply-To: <3BE1777F.30705@softhome.net> <3BE1A042.7030806@softhome.net> <3BE1A308.7030400@wanadoo.fr> <200111011945.fA1Jj0G09069@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick LeRoy wrote:

> On Thursday 01 November 2001 13:31, Pierre Rousselet wrote:
> 
>>Ricardo Martins wrote:
>>
>>> >> Procedure
>>> >> In X windows (version 4.1.0 compiled from the sources) when writing
>>> >> "exit" in xterm to close the terminal emulator, the window freezes,
>>> >> and from that moment on, every process becomes "unkillable",
>>> >> including
>>>
>>>xterm
>>>
>>> >> and X (ps also freezes), and there's no way to shutdown GNU/Linux in
>>> >> a sane way (must hit reset or poweroff).
>>> >
>>> >I can see the problem here with 2.4.13. I don't know if it's kernel
>>> >related, I'm used using rxvt, never xterm.
>>> >
>>> >It looks like xterm takes the terminal where you started X from.
>>> >
>>> >Are you using devfs ?
>>> >
>>> >
>>> >Pierre
>>>
>>>Pierre, yes, i'm using devfs that seems to be the problem, do you know
>>>how to fix it ?
>>>
>>Is it devfs or xterm which needs to be fixed ? I would
>>
>>suggest to switch to rxvt which works fine with/without devfs.
>>
> 
> With all due respect, I'd have to differ.....  Do you have any idea how many 
> people are running how many copies of xterm as we speak?  Even if we pair 
> that down to all those running devfs, it's certainly a substantial number.  
> The kernel should, above all else, run old applications without breaking them.
> 
> -Nick


devfs is still marked EXPERIMENTAL in the kernel building. If you select it you

must be prepared to tolerate some misbehaviour. rxvt is not newer than 
xterm, it is lighter.

Pierre



-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

