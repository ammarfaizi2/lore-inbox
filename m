Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319460AbSILHFm>; Thu, 12 Sep 2002 03:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319461AbSILHFm>; Thu, 12 Sep 2002 03:05:42 -0400
Received: from angband.namesys.com ([212.16.7.85]:13696 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S319460AbSILHFl>; Thu, 12 Sep 2002 03:05:41 -0400
Date: Thu, 12 Sep 2002 11:10:29 +0400
From: Oleg Drokin <green@namesys.com>
To: Arador <diegocg@teleline.es>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k at a time)
Message-ID: <20020912111029.A4997@namesys.com>
References: <20020910190950.A1064@namesys.com> <Pine.LNX.4.44.0209101504590.16518-100000@freak.distro.conectiva> <20020911193024.24fb7514.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020911193024.24fb7514.diegocg@teleline.es>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 11, 2002 at 07:30:23PM +0200, Arador wrote:

> > Huh, now that I released -pre6 _with_ this stuff by accident its too late.
> > Silly me.
> > Can you make me a tree which backouts the big write code please?
> > Will be releasing a -pre7 shortly due to that.
> Although some changes are going to be removed in -pre7, i've run tiobench to test the changes.
> Kernel versions are plain -pre4 and -pre6

What kind of hardware were these tests on?

Can you please conduct one more test with line 212 in fs/reiserfs/file.c
changed:
hint.preallocate = 0;
change 0 there to 1

Thank you.

Bye,
    Oleg
