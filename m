Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSBIUXg>; Sat, 9 Feb 2002 15:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287111AbSBIUX0>; Sat, 9 Feb 2002 15:23:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58123 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287134AbSBIUXK>;
	Sat, 9 Feb 2002 15:23:10 -0500
Message-ID: <3C6584F3.D571C1CB@zip.com.au>
Date: Sat, 09 Feb 2002 12:22:11 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paule@ilu.vu
CC: Chris Ball <chris@void.printf.net>, linux-kernel@vger.kernel.org
Subject: Re: 3com pcmcia modules.
In-Reply-To: <20020209151533.A644@ilu.vu> <877kpmvetv.fsf@lexis.house.pkl.net>,
		<877kpmvetv.fsf@lexis.house.pkl.net>; from chris@void.printf.net on Sat, Feb 09, 2002 at 03:45:48PM +0000 <20020209160407.A1222@ilu.vu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paule@ilu.vu wrote:
> 
> root@paule:/lib/modules/2.5.3/kernel/drivers/net# insmod 3c59x
> Using /lib/modules/2.5.3/kernel/drivers/net/3c59x.o
> /lib/modules/2.5.3/kernel/drivers/net/3c59x.o: unresolved symbol
> del_timer_sync

That can't happen :)

I have checked 2.5.4-pre5 SMP and UP, and the module loads
OK.  Possibly 2.5.3 was broken, but it's unlikely.  Please
try a `make clean'.  

-
