Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275758AbRJFWAZ>; Sat, 6 Oct 2001 18:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275754AbRJFWAP>; Sat, 6 Oct 2001 18:00:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8950
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S275752AbRJFWAD>; Sat, 6 Oct 2001 18:00:03 -0400
Date: Sat, 6 Oct 2001 15:00:24 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: low-latency patches
Message-ID: <20011006150024.C2625@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu> <3BBEA8CF.D2A4BAA8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BBEA8CF.D2A4BAA8@zip.com.au>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 11:46:39PM -0700, Andrew Morton wrote:
> Bob McElrath wrote:
> > 2) Will either of these ever be merged into Linus' kernel (2.5?)
> 
> Controversial.  My vague feeling is that they shouldn't.  Here's
> why:
> 
> The great majority of users and applications really only need
> a mostly-better-than-ten-millisecond latency.  This gives good
> responsiveness for user interfaces and media streaming.  This
> can trivially be achieved with the current kernel via a thirty line
> patch (which _should_ be applied to 2.4.x.  I need to get off my
> butt).
> 
> But the next rank of applications - instrumentation, control systems,
> media production sytems, etc require 500-1000 usec latencies, and
> the group of people who require this is considerably smaller.  And their
> requirements are quite aggressive.  And maintaining that performance
> with either approach is a fair bit of work and impacts (by definition)
> the while kernel.  That's all an argument for keeping it offstream.
> 

And exactly how is low latency going to hurt the majority?

This reminds me of when 4GB on ia32 was enough, or 16 bit UIDs, or...

Should those have been left out too just because the people who needed them
were few?

If the requirements for manufacturing control, or audio processing, or etc
will make my home box, or my server work better then why not include it?

