Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSCYVDX>; Mon, 25 Mar 2002 16:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312576AbSCYVDN>; Mon, 25 Mar 2002 16:03:13 -0500
Received: from [209.250.53.144] ([209.250.53.144]:55814 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S312575AbSCYVDF>; Mon, 25 Mar 2002 16:03:05 -0500
Date: Mon, 25 Mar 2002 15:02:44 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Marc Wilson <msw@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Message-ID: <20020325210244.GB14966@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Marc Wilson <msw@cox.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <20020323160647.GA22958@hapablap.dyn.dhs.org> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au> <200203241507.g2OF7WN26069@ls401.hinet.hr> <1017020598.420771.13343.nullmailer@bozar.algorithm.com.au> <20020325085053.GB1382@moonkingdom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uptime: 06:05:34 up 4 days,  5:02,  0 users,  load average: 1.07, 1.02, 1.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 12:50:53AM -0800, Marc Wilson wrote:
> On Mon, Mar 25, 2002 at 12:43:18PM +1100, Andre Pang wrote:
> > Can somebody with a KT133/KT133A do a "lspci -n" and grep for
> > '8305'?  If it doesn't appear, I'll send off my patch.
> 
> Sorry to disappoint you:
> 
> $ sudo lspci -n | grep 8305
> 00:01.0 Class 0604: 1106:8305
> 
> It's an Abit KT7A-RAID, which is a KT133A.
> 
> Having said that, I've been seeing odd video artifacts in xawtv windows
> since the patch was expanded from merely clearing bit 7. :)

Is that to say, you suspect clearing bits 5 and 6 is causing you
trouble?  If so, by all means try the patch I posted to the list.  If
you can't find it in the archives or google groups or whatnot, I'll send
it to you directly.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
