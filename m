Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130450AbRC3Cz2>; Thu, 29 Mar 2001 21:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbRC3CzS>; Thu, 29 Mar 2001 21:55:18 -0500
Received: from chromium11.wia.com ([207.66.214.139]:260 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S130450AbRC3CzE>; Thu, 29 Mar 2001 21:55:04 -0500
Message-ID: <3AC3F638.FE761EAB@chromium.com>
Date: Thu, 29 Mar 2001 18:58:00 -0800
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Kravetz <mkravetz@sequent.com>, linux-kernel@vger.kernel.org
Subject: Re: linux scheduler limitations?
In-Reply-To: <Pine.LNX.4.33.0103291326110.26411-100000@dlang.diginsite.com> <3AC3AF3E.F083EE36@chromium.com> <20010329174549.A1264@w-mikek2.sequent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

somebody else on the list already pointed me at your stuff and I quickly
downloaded your multiqueue patch for 2.4.1 to try it out.

It works great! I finally manage to have 100% CPU utilization and keep the
machine decently responsive.

On a two 1GHz pentium box i went from 1300 specweb to 1600. That's pretty
amazing.

There is a bit more overhead though, I'd say arount 5%, when the CPU is not
fully loaded.

What is the status of your code? Is it going to end-up in the mainstream
kernel?

Do you have a port to the 2.4.2x kernels?

In my enthousiasm I tried to port the patch to 2.4.2-ac26 but I broke
something and it didn't work anymore... :)

I havent't tried the pooling patch yet, it didn't seem to make much sense on a
2-way box. I have an 8-way on which I'm planning to bench my web server
enhancements, I'll try the pooling stuff on it.

BTW: interested in the fastest linux web server?

BTW2: what about the HP scheduler patches?

Thanks, ciao,

 - Fabio

Mike Kravetz wrote:

> On Thu, Mar 29, 2001 at 01:55:11PM -0800, Fabio Riccardi wrote:
> > I'm using 2.4.2-ac26, but I've noticed the same behavior with all the 2.4
> > kernels I've seen so far.
> >
> > I haven't even tried on 2.2
> >
> >  - Fabio
>
> Fabio,
>
> Just for fun, you might want to try out some of our scheduler patches
> located at:
>
> http://lse.sourceforge.net/scheduling/
>
> I would be interested in your observations.
>
> --
> Mike Kravetz                                 mkravetz@sequent.com
> IBM Linux Technology Center

