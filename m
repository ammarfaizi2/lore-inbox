Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278537AbRJSQkf>; Fri, 19 Oct 2001 12:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278538AbRJSQk0>; Fri, 19 Oct 2001 12:40:26 -0400
Received: from [65.198.37.66] ([65.198.37.66]:11705 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S278537AbRJSQkG>; Fri, 19 Oct 2001 12:40:06 -0400
Date: Fri, 19 Oct 2001 09:37:23 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: Mario Mikocevic <mozgy@hinet.hr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: RAID and 2.4.12 ?
In-Reply-To: <20011019173434.A10220@danielle.hinet.hr>
Message-ID: <Pine.LNX.4.33.0110190935580.794-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Oct 2001, Mario Mikocevic wrote:

> Hi,
>
> are there any known problems with software raid and kernel 2.4.12 ?
>
> I have several production servers (Dell poweredge 1550) with active
> kernels from range of 2.4.8/2.4.9/2.4.12. All of them are quite loaded
> with web/ftp/game/realmedia servers.
>
> Only combination of RAID and 2.4.12 gives me trouble, complete hang,
> no output, no ping. Unfortunately I can't reproduce it by will, sometimes
> it hangs just after few mins of uptime, sometimes after few hours.
>
> I _do_ have few servers running 2.4.12 quite realiably (not a single reboot yet)
> but without RAID on them (heavily loaded list server and very heavily loaded
> realmedia server).
>
> Combination of 2.4.9 and RAID works without any problem so far.

I only have anecdotal evidence, but 2.4.12 worked fine for my on a single
SCSI disk but as soon as I mounted my root device on RAID 0, the kernel
would oops  (after ~30 seconds up uptime) and all processes which write to
the disk would be unkillable.

I switched to 2.4.12-ac3 with no problems (yet).

-jwb

