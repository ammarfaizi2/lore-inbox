Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSEUUXy>; Tue, 21 May 2002 16:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSEUUXx>; Tue, 21 May 2002 16:23:53 -0400
Received: from web14202.mail.yahoo.com ([216.136.172.144]:19338 "HELO
	web14202.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316586AbSEUUXw>; Tue, 21 May 2002 16:23:52 -0400
Message-ID: <20020521202351.42147.qmail@web14202.mail.yahoo.com>
Date: Tue, 21 May 2002 13:23:51 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: Re: Kernel BUG 2.4.19-pre8-ac1 + preempt
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020521195317.GH2046@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's preempt-kernel-rml-2.4.19-pre8-ac1-1.patch from
http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/linux-2.4/preempt-kernel-rml-2.4.19-pre8-ac1-1.patch

It applied cleanly with no mods needed and had been running fine untill this
decided to happen.  Seems like slocate's updatedb decided to jack the load up
which triggered oom?  However, the chosen process was unkillable since its the
same process listed in the oom report over and over again?


--- William Lee Irwin III <wli@holomorphy.com> wrote:
> On Tue, May 21, 2002 at 12:43:49PM -0700, Erik McKee wrote:
> > Hello
> > This output...
> > kernel BUG at /usr/src/linux-2.2.13/include/linux/mm_inline.h:78!
> 
> Can I see the patch you used to merge preempt?
> 
> 
> Cheers,
> Bill

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
