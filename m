Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbRH0VNC>; Mon, 27 Aug 2001 17:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268970AbRH0VMx>; Mon, 27 Aug 2001 17:12:53 -0400
Received: from mail.spylog.com ([194.67.35.220]:40601 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S268963AbRH0VMk>;
	Mon, 27 Aug 2001 17:12:40 -0400
Date: Tue, 28 Aug 2001 01:12:51 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Updated Linux kernel preemption patches
Message-ID: <20010828011251.A32227@spylog.ru>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <998877465.801.19.camel@phantasy> <20010827093835.A15153@oisec.net> <3B8AA02D.6F7561AB@lexus.com> <998941465.1993.9.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <998941465.1993.9.camel@phantasy>
User-Agent: Mutt/1.3.20i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robert Love,

Once you wrote about "Re: Updated Linux kernel preemption patches":
> On Mon, 2001-08-27 at 15:31, J Sloan wrote:
> > I get the same error -
> > 
> > RH 7.1 + updates and bits of rawhide -
> 
> I am looking into this, but I do not have this problem (which is odd).
> 
> The patch wraps one define of atomic_dec_and_lock in an #ifndef
> CONFIG_PREEMPT, but I assume there is another defination elsewhere.  For
> whatever reason, my kernel compiles fine.
> 
> I am going to update the patch to 2.4.9-ac2, give that a try.
> 
> Wait a second...you are _ENABLING_ the configure option, right?  Always
> run `make oldconfig' !!!  If you are not, in this case, the patch is
> breaking compiles where CONFIG_PREEMPT is not set...now I can fix that.
> Please let me know.

I am doing:

make clean
make menuconfig (load my config; enable/disable option if need)
make dep
make bzImage
(break with error)


Where should be "make oldconfig" ?

-- 
bye.
Andrey Nekrasov, SpyLOG.
