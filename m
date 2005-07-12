Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVGLW3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVGLW3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVGLWYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:24:33 -0400
Received: from dvhart.com ([64.146.134.43]:31414 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262471AbVGLWWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:22:46 -0400
Date: Tue, 12 Jul 2005 15:22:36 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>" 
	<k.s.matheussen@notam02.no>,
       Chris Friesen <cfriesen@nortel.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <278570000.1121206956@flay>
In-Reply-To: <1121201925.10580.24.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <20050709203920.394e970d.diegocg@gmail.com> <1120934466.6488.77.camel@mindpipe>  <176640000.1121107087@flay> <1121113532.2383.6.camel@mindpipe>  <42D2D912.3090505@nortel.com> <1121128260.2632.12.camel@mindpipe>  <165840000.1121141256@[10.10.2.4]> <1121141602.2632.31.camel@mindpipe>  <188690000.1121142633@[10.10.2.4]> <1121201925.10580.24.camel@mindpipe>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, July 12, 2005 16:58:44 -0400 Lee Revell <rlrevell@joe-job.com> wrote:

> On Mon, 2005-07-11 at 21:30 -0700, Martin J. Bligh wrote:
>> Some sort of comprimise has to be struck for now, until we get sub-HZ
>> timers. I'd prefer 100, personally (I had that set as default in my tree
>> for a long time). Some people would prefer 1000 or even more, maybe.
>> 250/300 seems like a reasonable comprimise to me. Exactly what problems
>> *does* it cause (in visible effect, not "timers are less granular").
>> Jittery audio/video? How much worse is it?
> 
> OK, here's a real world example, taken straight from the linux-audio-dev
> list today.

OK, what level causes Midi stuttering to stop then, under some fairly
reasonable load? Of course ... if we set HZ to 100000, we'll get higher
res still ... the question is how high it *needs* to be ;-)

M.


