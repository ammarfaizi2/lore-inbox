Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279614AbRKATdg>; Thu, 1 Nov 2001 14:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279622AbRKATd0>; Thu, 1 Nov 2001 14:33:26 -0500
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:46315 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S279614AbRKATdM>; Thu, 1 Nov 2001 14:33:12 -0500
Message-ID: <3BE1A308.7030400@wanadoo.fr>
Date: Thu, 01 Nov 2001 20:31:20 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ricardo Martins <thecrown@softhome.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: on exit xterm  totally wrecks linux 2.4.11 to 2.4.14-pre6 (unkillable processes)
In-Reply-To: <3BE1777F.30705@softhome.net> <3BE1A042.7030806@softhome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ricardo Martins wrote:

>  >> Procedure
>  >> In X windows (version 4.1.0 compiled from the sources) when writing
>  >> "exit" in xterm to close the terminal emulator, the window freezes, and
>  >> from that moment on, every process becomes "unkillable", including 
> xterm
>  >> and X (ps also freezes), and there's no way to shutdown GNU/Linux in a
>  >> sane way (must hit reset or poweroff).
> 
> 
>  >I can see the problem here with 2.4.13. I don't know if it's kernel
>  >related, I'm used using rxvt, never xterm.
> 
>  >It looks like xterm takes the terminal where you started X from.
> 
>  >Are you using devfs ?
> 
> 
>  >Pierre
> 
> 
> Pierre, yes, i'm using devfs that seems to be the problem, do you know 
> how to fix it ?
 
Is it devfs or xterm which needs to be fixed ? I would

suggest to switch to rxvt which works fine with/without devfs.


Pierre

-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

