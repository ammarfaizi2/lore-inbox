Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbRETEbW>; Sun, 20 May 2001 00:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbRETEbM>; Sun, 20 May 2001 00:31:12 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:58120 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S261410AbRETEa7>; Sun, 20 May 2001 00:30:59 -0400
Date: Sun, 20 May 2001 16:30:41 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@suse.cz>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
Message-ID: <20010520163041.A6260@metastasis.f00f.org>
In-Reply-To: <20010515161750.B38@toy.ucw.cz> <Pine.LNX.4.21.0105191238040.14472-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105191238040.14472-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, May 19, 2001 at 12:39:18PM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 12:39:18PM -0700, Linus Torvalds wrote:

    Note that "resume from disk" does _not_ have to necessarily
    resume kernel data structures. It is enough if it just resumes
    the caches etc.

For speeding up a boot process, sure... but for suspend/resume on a
laptop --- why would you bother?

    Don't get _too_ hung up about the power-management kind of
    "invisible suspend/resume" sequence where you resume the whole
    kernel state.

I'm confused. I've always wondered that before you suspend the state
of a machine to disk, why we just don't throw away unnecessary data
like anything not actively referenced.



  --cw
