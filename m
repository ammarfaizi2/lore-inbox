Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272533AbRI0MS0>; Thu, 27 Sep 2001 08:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272677AbRI0MSQ>; Thu, 27 Sep 2001 08:18:16 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:4454 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S272546AbRI0MSI>; Thu, 27 Sep 2001 08:18:08 -0400
Date: Thu, 27 Sep 2001 12:17:44 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Disconnect <lkml@sigkill.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10
Message-ID: <20010927121744.A1050@grobbebol.xs4all.nl>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <20010924032518.A8680@emma1.emma.line.org> <20010923225756.A2823@sigkill.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010923225756.A2823@sigkill.net>; from lkml@sigkill.net on Sun, Sep 23, 2001 at 10:57:57PM -0400
X-OS: Linux grobbebol 2.4.10 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 10:57:57PM -0400, Disconnect wrote:
> > several partitions. 2.4.9 is fine, 2.4.9-ac7, -ac10 and 2.4.10 are
> > broken.
> 
> Ditto here, at least as far back as 2.4.8-ac2 (nvidia driver blew up on
> ac7 so I haven't tried anything more recent).
> 
> Tried to log out to reboot to 2.4.10+k7fix and logging out (X restarted)
> triggered it.  (I have -got- to get to journalled root fs one of these
> days.)

I have reported this many months ago. sometimes, it keeps working for
days, weeks. sometimes, the hell just reaks loose after a short time.

when this happens, I can access via TCP but the timers seem to be slow,
like one secoint time tick happening in several minutes. this makes the
system _slow_ and looks like a crash.


-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
