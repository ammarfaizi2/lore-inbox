Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316960AbSEaW1K>; Fri, 31 May 2002 18:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSEaW1K>; Fri, 31 May 2002 18:27:10 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:38922
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S316960AbSEaW1J>; Fri, 31 May 2002 18:27:09 -0400
Date: Fri, 31 May 2002 15:26:51 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: js@cionix.de
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: Very High Load on Disk Activity in 2.4.18 (and 2.4.18-pre8)
Message-ID: <20020531222651.GA874@matchmail.com>
Mail-Followup-To: js@cionix.de, vda@port.imtp.ilyichevsk.odessa.ua,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020525121737Z314546-22651+55555@vger.kernel.org> <1022329607.3cef83072437b@mail.cionix.de> <200205290719.g4T7JVY25856@Port.imtp.ilyichevsk.odessa.ua> <1022750361.3cf5ee99434bf@mail.cionix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 11:19:21AM +0200, Jan Schreiber wrote:
> Hello,
> 
> > > I'm experiencing a strange effect. As soons as there is some higher disk
> > > activity (untarring the linux kernel is enough, which really should be no
> > > problem) the system load gets really high (some times over 10) but the
> > CPU
> > > is 100% idle (reported by top).
> > 
> > Which processes aren't sleeping? Look for STAT values other than 'S'
> > and/or type 'i' to switch top into no-idle mode.
> 
> First i would like to thank you for your answer 
> 
> When i do a simple "find / * | grep bla bla" the Load is over 3 after
> 10 seconds and about 10 after a minute.
> 
> I did a "top" and switched to non-idle mode. The only processes that appear
> constantly when the load is such high are "kupdated" and "kreiserfsd". Any
> ideas?
> 

run:

ps ax|grep " D"

And list the output here.  Also, is anything else running at the time?
