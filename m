Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752180AbWAETdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbWAETdg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbWAETdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:33:36 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:2223 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752180AbWAETdf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:33:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WrJjPmDDeBRYTWZ2HIFUQ6l8Hu1zlb5Fnt0S/iZ+xiZRn+doETsoTa6HG92d2DzzyWGw94FiKMEdIAew8gYMmlYGpyklui96wqsQRx57RhIkjt8rhbiC7ZtvJuGQ/PMlQ9r2dJLuVHUl4GuJ1NOnKSv1oskjXZiLpdVmZSc7WvA=
Message-ID: <5bdc1c8b0601051133g6ed0b3b4ob699d65e4a12b699@mail.gmail.com>
Date: Thu, 5 Jan 2006 11:33:33 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.15-rc7-rt1
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1136205719.6039.156.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051228172643.GA26741@elte.hu>
	 <Pine.LNX.4.61.0512311808070.7910@yvahk01.tjqt.qr>
	 <1136051113.6039.109.camel@localhost.localdomain>
	 <1136054936.6039.125.camel@localhost.localdomain>
	 <5bdc1c8b0601010719h40f2393cu85bae52fef35c1d2@mail.gmail.com>
	 <1136205719.6039.156.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> FYI,
>
> Ingo has been paying attention to this thread :)
>
> 2.6.15-rc7-rt2 is out and contains this patch.
>
> -- Steve

Hi all,
   Sorry for the delay. We had a 3 day power failure here in Northern
California and I'm just getting back in the swing of things starting
yesterday.

   I have installed 2.6.15-rt2 and I no longer see the error

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at include/linux/timer.h:83
invalid operand: 0000 [1] PREEMPT
CPU 0

in my dmesg file. Thanks for fixing that.

   I expect that I am probably still getting a low level of xruns. I
hope one day we can make that work a bit better. In the mean time no
problems with mplayer or MythTV so far.

Cheers,
Mark
