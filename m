Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269395AbRHRXlj>; Sat, 18 Aug 2001 19:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269417AbRHRXl2>; Sat, 18 Aug 2001 19:41:28 -0400
Received: from mercury.is.co.za ([196.4.160.222]:44556 "HELO mercury.is.co.za")
	by vger.kernel.org with SMTP id <S268970AbRHRXlW>;
	Sat, 18 Aug 2001 19:41:22 -0400
Date: Sun, 19 Aug 2001 01:40:21 +0200
From: Dewet Diener <dewet@dewet.org>
To: Riley Williams <rhw@MemAlpha.CX>
Cc: Stephen C Tweedie <sct@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 partition unmountable
Message-ID: <20010819014021.B26332@darkwing.flatlit.net>
In-Reply-To: <20010818235211.A24646@darkwing.flatlit.net> <Pine.LNX.4.33.0108182257490.9206-100000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108182257490.9206-100000@infradead.org>; from rhw@MemAlpha.CX on Sat, Aug 18, 2001 at 11:04:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2001 at 11:04:41PM +0100, Riley Williams wrote:
> The relevant mount option is to specify the ext3 rather than the ext2
> file system, and the flag you refer to gets set if ANYBODY sets the
> "COMPRESS THIS FILE" flag on ANY file on that file system. As far as I
> can tell, nothing ever resets that flag, even if the last file that
> was compressed gets uncompressed.

I doubt that ever happened - its pretty much a single-user system,
and I can't say that I quite know *how* to set that flag in the first
place :)

> You have an old version of tune2fs, and need to get the one that knows
> about ext3 or alternatively apply the patch that was distributed some
> time ago and recompile - I'm not sure which.
> 
> Stephen: What's the current status regarding tune2fs and ext3, I'm a
> tad out of date in this respect?

I'm running e2fsprogs-1.22 (which is later than the one specified from
Documentation/Changes), so I kinda assumed everything was fine...

Dewet

