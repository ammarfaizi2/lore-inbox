Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132559AbRAaRXS>; Wed, 31 Jan 2001 12:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132497AbRAaRW6>; Wed, 31 Jan 2001 12:22:58 -0500
Received: from 05-admin.deltav.hu ([213.163.4.101]:18180 "EHLO oxygene.albi.hu")
	by vger.kernel.org with ESMTP id <S132555AbRAaRWq>;
	Wed, 31 Jan 2001 12:22:46 -0500
Date: Wed, 31 Jan 2001 18:21:24 +0100
From: Gabor Lenart <lgb@lgb.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/REQ] Increase kmsg buffer from 16K to 32K, kernel/printk.c
Message-ID: <20010131182124.A1890@supervisor.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <3A72804A.E6052E1B@linux.com> <E14O0hv-0002hY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14O0hv-0002hY-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 31, 2001 at 05:06:07PM +0000
X-Operating-System: oxygene Linux 2.2.18 i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 05:06:07PM +0000, Alan Cox wrote:
> > Does Linus or anyone object to raising the ksmg buffer from 16K to 32K?
> > 4/5 systems I have now overflow the buffer during boot before init is
> > even launched.
> 
> Thats just an indication that 2.4.x is currently printking too much crap on
> boot

Would it be possible to grow and shring that buffer on demand? Let's say
we have a default size and let it grow to a maximum value. After some
timeout, buffer size can be shrinked to default value if it's enough at
that moment. Or something similar.

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]--[ lgb@supervisor.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
