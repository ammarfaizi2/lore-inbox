Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268322AbTAMVxL>; Mon, 13 Jan 2003 16:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268351AbTAMVxK>; Mon, 13 Jan 2003 16:53:10 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:9998 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S268322AbTAMVxK>;
	Mon, 13 Jan 2003 16:53:10 -0500
Date: Mon, 13 Jan 2003 15:02:00 -0700
From: Val Henson <val@nmt.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113220200.GD19731@boardwalk>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org> <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
User-Agent: Mutt/1.4i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 04:27:30PM -0500, Rob Wilkens wrote:
> 
> I've only compiled (and haven't tested this code), but it should be much
> faster than the original code.  Why?  Because we're eliminating an extra
> "jump" in several places in the code every time open would be called. 
> Yes, it's more code, so the kernel is a little bigger, but it should be
> faster at the same time, and memory should be less of an issue nowadays.

To the tune of "Teen Angst" from Cracker:

  Cause, what the world needs now,
  is another theoretical optimizer
  like I need a hole in my head.

You'd think I'd be resigned to the l-k tradition of the unbenchmarked
"optimization" patch, but apparently not yet...

-VAL
