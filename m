Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRBSWuD>; Mon, 19 Feb 2001 17:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129378AbRBSWty>; Mon, 19 Feb 2001 17:49:54 -0500
Received: from inspiron.swusa.com ([207.214.125.61]:4232 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S130066AbRBSWte>;
	Mon, 19 Feb 2001 17:49:34 -0500
Message-ID: <20010219144935.D21425@saw.sw.com.sg>
Date: Mon, 19 Feb 2001 14:49:35 -0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Dragan Stancevic <visitor@valinux.com>
Subject: Re: eepro100 + 2.2.18 + laptop problems
In-Reply-To: <20010211224033.G352@zip.com.au> <20010213092638.A11218@saw.sw.com.sg> <20010213151409.Q352@zip.com.au> <20010220092106.D365@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010220092106.D365@zip.com.au>; from "CaT" on Tue, Feb 20, 2001 at 09:21:06AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 20, 2001 at 09:21:06AM +1100, CaT wrote:
> On Tue, Feb 13, 2001 at 03:14:09PM +1100, CaT wrote:
> > On Tue, Feb 13, 2001 at 09:26:38AM +0800, Andrey Savochkin wrote:
> > > On Sun, Feb 11, 2001 at 10:40:33PM +1100, CaT wrote:
> > > [snip]
> > > > Feb 11 22:30:18 theirongiant kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
> > > 
> > > Please try the attached patch.
> > > Actually, it's designed to solve another problem, but may be your one has the
> > > same origin as that other.
> > 
> > Cool. Thanks. I recompiled the module and am trying it now. So far the
> > ethernet connection is fine but the above problem isn't reproducable with 
> > 100% accuracy and so it'll take me a wee while before I decide 'oooo....
> > aaaaa... that rocks my boat. it's fixed.'. :)
> 
> It happened again. Same deal. Once was after a reboot and this time
> was after a resume. :/

In my experiments wait_for_cmd timeouts almost always were related to
DumpStats command.
I think, we need to investigate what time constraints are related to this
command.

Best regards
		Andrey
