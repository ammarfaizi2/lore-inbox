Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSEHQtv>; Wed, 8 May 2002 12:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314705AbSEHQtu>; Wed, 8 May 2002 12:49:50 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17937 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314702AbSEHQtt>; Wed, 8 May 2002 12:49:49 -0400
Date: Wed, 8 May 2002 12:46:18 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Tomasz Rola <rtomek@cis.com.pl>, James <jdickens@ameritech.net>
cc: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Can't Burn CDR's On 2.4.19pre8
In-Reply-To: <20020508072001.WWPH3647.mailhost.mil.ameritech.net@there>
Message-ID: <Pine.LNX.3.96.1020508124013.3449B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Tomasz Rola wrote:

> On Mon, 6 May 2002, Johannes Ruscheinski wrote:

> > I don't know whether I have a hardware problem or a kernel problem.  Here's
> > what I get when I try to dummy burn a data CDR on 2.4.19pre8:
> > 
> 
> Forgive me this insulting question, but have you tried to burn another CD?

  "dummy" is a technical term, applying to the curn method and your
answer;-) Don't you hate it when you read past information like that?


On Wed, 8 May 2002, James wrote:

> I have read that Disk at Once mode works for writers that understand that 
> mode of writing, but the track at once is the one that is currently broken, 
> that explains why some us are complaining and others say that all is fine.

DAO should work for any device which supports it. That's not double-speak,
cdrecord returns the capabilities of the drive, and I believe it correctly
rejects asking for something the hardware can't do.

Read the docs carefully, I believe you can use RAW96 or similar modes on
older burners. I doubt that's the problem, though, I suspect burner
hardware.

The cd burning list is cdwrite@other.debian.org, send "subscribe cdwrite"
to majordomo there and ask the list if you don't get all you need there.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

