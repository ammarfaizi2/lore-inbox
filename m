Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272062AbRIMVGp>; Thu, 13 Sep 2001 17:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272101AbRIMVGf>; Thu, 13 Sep 2001 17:06:35 -0400
Received: from [24.254.60.20] ([24.254.60.20]:60566 "EHLO
	femail30.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272062AbRIMVGZ>; Thu, 13 Sep 2001 17:06:25 -0400
Date: Thu, 13 Sep 2001 16:05:53 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Funny Syslog-Message...
Message-ID: <20010913160553.A2307@cy599856-a.home.com>
Mail-Followup-To: josh, linux-kernel@vger.kernel.org
In-Reply-To: <3BA1060B.525DC521@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA1060B.525DC521@t-online.de>
User-Agent: Mutt/1.3.20i
From: Josh McKinney <forming@home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm no kernel-hacker but a quick grep through the kernel source points to
tcp_timer.c, line 338.  There are some comments about what is going on.  As far
as I can tell it is not a problem.

On approximately Thu, Sep 13, 2001 at 09:16:27PM +0200, Frank Schneider wrote:
> Hello...
> 
> Had just this message in /var/log/messages:
> 
> -------------
> Sep 13 21:07:00 falcon kernel: TCP: Treason uncloaked! Peer
> 192.168.1.254:515/757 shrinks window 3368746969:3368747993. Repaired.
> Sep 13 21:07:13 falcon last message repeated 5 times
> -------------
> 
> Did not know that my system owns a "cloaking device"...shall i be
> careful that it does not dissapear sometime ? :-)
> 
> Does anyone know whats meant here ?
> The IP is my printerbox, the message comes often when i print...but the
> printout is normally OK.
> 
> Solong..
> Frank.
> 
> --
> Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
> Microsoft isn't the answer.
> Microsoft is the question, and the answer is NO.
> ... -.-
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Linux, the choice          | /* And you'll never guess what the dog had 
of a GNU generation   -o)  | */ /*   in its mouth... */              -- 
Kernel 2.4.9-ac1       /\  | Larry Wall in stab.c from the perl source
on a i586             _\_v | code 
                           | 
