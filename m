Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269165AbRHBVo6>; Thu, 2 Aug 2001 17:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269162AbRHBVos>; Thu, 2 Aug 2001 17:44:48 -0400
Received: from unthought.net ([212.97.129.24]:43714 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S267163AbRHBVok>;
	Thu, 2 Aug 2001 17:44:40 -0400
Date: Thu, 2 Aug 2001 23:44:34 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
Message-ID: <20010802234434.E7650@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	"Jeffrey W. Baker" <jwbaker@acm.org>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010802165949.7742A-100000@chaos.analogic.com> <Pine.LNX.4.33.0108021409100.21298-100000@heat.gghcwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0108021409100.21298-100000@heat.gghcwest.com>; from jwbaker@acm.org on Thu, Aug 02, 2001 at 02:11:21PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 02:11:21PM -0700, Jeffrey W. Baker wrote:
> 
> 
> On Thu, 2 Aug 2001, Richard B. Johnson wrote:
> 
> > Well I don't have any such problems here. I wrote this script
> > from your instructions. I don't know if you REALLY wanted all
> > the file content to go out to the screen, but I wrote it explicitly.
> 
> [snip]
> 
> > Script started on Thu Aug  2 16:50:47 2001
> > # ps -laxw | grep pause
> >    140     0    16     1  -1 -20    712    40 pause       S < ?   0:00 (bdflush) te
> >      0     0  7433     1   9   0 321056 137808 pause       S    1  0:02 /tmp/try
> >      0     0  7631  7626  19   0    844   240             R   p0  0:00 grep pause
> > # cat /proc/meminfo
> >         total:    used:    free:  shared: buffers:  cached:
> > Mem:  328048640 326234112  1814528        0  4255744 173219840
> > Swap: 1069268992 189992960 879276032
>                              ^^^^^^^^^
> You still have almost 1GB of swap left.  I mean use all the memory in your
> box, RAM + swap.
> 
> As I said, I expect degraded performance but not a complete meltdown.

What ?

You fill up mem and you fill up swap, and you complain the box is acting funny ??

This is a clear case of "Doctor it hurts when I ..."  -  Don't do it !

I'm interested in hearing how you would accomplish graceful performance
degradation in a situation where you have used up any possible resource on the
machine.  Transparent process back-tracking ?   What ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
