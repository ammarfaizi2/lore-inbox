Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264759AbTFWH44 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTFWH4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:56:55 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:62594 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264759AbTFWH4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:56:47 -0400
Date: Mon, 23 Jun 2003 10:10:44 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Samphan Raruenrom <samphan@thai.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Crusoe's performance on linux?
Message-ID: <20030623101044.A9220@ucw.cz>
References: <3EF1E6CD.4040800@thai.com> <20030619200308.A2135@ucw.cz> <3EF2144D.5060902@thai.com> <20030619221126.B3287@ucw.cz> <3EF67AD4.4040601@thai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EF67AD4.4040601@thai.com>; from samphan@thai.com on Mon, Jun 23, 2003 at 10:58:12AM +0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 10:58:12AM +0700, Samphan Raruenrom wrote:
> Vojtech Pavlik wrote:
> > Could you a test just for me? Take vanilla 2.4.21 and then
> > make oldconfig; make dep; time make bzImage 
> > That's basically what I want to know how long will take, since
> > it's one of the most common time consuming tasks the thing will
> > have to handle.
> Done! Here're the results:-
> 
> Desktop - Pentium III 1 G Hz 754 MB	->	10.x min.
> Tablet PC - Crusoe TM5800 1 GHz 731 MB	->	17.x min.
> 
>  From freshdiagnos benchmack, the TPC has about 2x faster RAM.
> I use tmpfs for the whole process so disk speed didn't count.
> Both test run without X or any foreground process using
> 2.4.21-ac1 and RedHat kernel.
> 
> What do you think?
> Shouldn't TM5800 with 4-wide VLIW engine and 64 registers,
> working on a single task, run as fast as a Pentium III?
> Why it take 70% longer for such small process (make+gcc+as)!
> There must be something wrong.

Same GCC version on both? Which?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
