Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310529AbSCPTlB>; Sat, 16 Mar 2002 14:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310533AbSCPTkl>; Sat, 16 Mar 2002 14:40:41 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:65031 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S310529AbSCPTkf>;
	Sat, 16 Mar 2002 14:40:35 -0500
Date: Sat, 16 Mar 2002 11:40:25 -0800
From: Greg KH <greg@kroah.com>
To: Gordon J Lee <gordonl@world.std.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
Message-ID: <20020316194025.GA10571@kroah.com>
In-Reply-To: <3C927F3E.7C7FB075@world.std.com> <20020315234333.GH5563@kroah.com> <3C92B1EA.F40BDBD5@world.std.com> <20020316055542.GA8125@kroah.com> <3C938093.D1640CB6@world.std.com> <20020316173434.GB10003@kroah.com> <3C938693.6D29979C@world.std.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C938693.6D29979C@world.std.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 16 Feb 2002 17:38:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 12:53:23PM -0500, Gordon J Lee wrote:
> > > 2.4.18  shows two processors
> > > 2.4.19-pre3 shows two processors
> > > 2.4.19-pre3-ac1 shows four processors
> >
> > Great, thanks for testing.  I'd recommend using this hardware :)

Sorry, I meant to say, "I'd recommend using this kernel version".

> From your earlier post, I presume that the bug here was simply a presentation
> layer bug in /proc/cpuinfo, and that kernel versions previous to 2.4.19-pre3-ac1
> can actually use all of the logical processors.  Is this correct ?

No, the other processors are not recognized by Linux at all.  You need
that kernel version to properly use all of the logical processors.

> If so, at which 2.4.x kernel did support for hyperthreading show up?

In one of the 2.4.19-ac kernels from what I remember, sorry I don't know
the exact version.

Hope this helps,

greg k-h
