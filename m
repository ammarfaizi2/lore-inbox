Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSETEbE>; Mon, 20 May 2002 00:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315752AbSETEbD>; Mon, 20 May 2002 00:31:03 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:37383
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315746AbSETEbD>; Mon, 20 May 2002 00:31:03 -0400
Date: Sun, 19 May 2002 21:31:01 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Wayne.Brown@altec.com
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Message-ID: <20020520043101.GA502@matchmail.com>
Mail-Followup-To: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org,
	Keith Owens <kaos@ocs.com.au>
In-Reply-To: <20020518092715Z293457-22651+36580@vger.kernel.org> <86256BBD.00606F38.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2002 at 12:32:25PM -0500, Wayne.Brown@altec.com wrote:
> I never expected everyone to abandon their own needs to satisfy mine.  It would
> be nice if they tried to accomodate my needs while satisfying their own, but I
> didn't expect that either.  

IIRC, Kbuild-2.5 already silently accepts all of the old kbuild-2.4 commands
without problems.

As long as you end up running "make install" the rest of the old commands
will be ignored.  You can go on with all of the old commands, if you want
without any trouble.  This will allow you to use the same commands with
kbuild-2.4 and kbuild-2.5, in case you decide to switch between both kernels
and want to use the same commands.

Also kbuild-2.5 does have features that allow you to call scripts from "make
install", but it's not mandatory.

Kieth, can you confirm that all of the old kbuild-2.4 commands have been
wrapped in kbuild-2.5 commands?

Thanks,

Mike
