Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287500AbSALVSD>; Sat, 12 Jan 2002 16:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287508AbSALVRx>; Sat, 12 Jan 2002 16:17:53 -0500
Received: from ns.ithnet.com ([217.64.64.10]:8452 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287500AbSALVRp>;
	Sat, 12 Jan 2002 16:17:45 -0500
Date: Sat, 12 Jan 2002 22:16:57 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: ed.sweetman@wmich.edu, andrea@suse.de, yodaiken@fsmlabs.com,
        jogi@planetzork.ping.de, rml@tech9.net, alan@lxorguk.ukuu.org.uk,
        nigel@nrg.org, landley@trommello.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020112221657.1851a41a.skraw@ithnet.com>
In-Reply-To: <3C409B2D.DB95D659@zip.com.au>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu>
	<1010781207.819.27.camel@phantasy>
	<20020112121315.B1482@inspiron.school.suse.de>
	<20020112160714.A10847@planetzork.spacenet>
	<20020112095209.A5735@hq.fsmlabs.com>
	<3C409B2D.DB95D659@zip.com.au>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2002 12:23:09 -0800
Andrew Morton <akpm@zip.com.au> wrote:

> Ed Sweetman wrote:
> > 
> > If you want to test the preempt kernel you're going to need something that
> > can find the mean latancy or "time to action" for a particular program or
> > all programs being run at the time and then run multiple programs that you
> > would find on various peoples' systems.   That is the "feel" people talk
> > about when they praise the preempt patch.
> 
> Right.  And that is precisely why I created the "mini-ll" patch.  To
> give the improved "feel" in a way which is acceptable for merging into
> the 2.4 kernel.

Hm, I am not quite sure about what you expect to hear about it, but:

a) It applies cleanly to 2.4.18-pre3.
b) It compiles
c) During a load of around 150 produced by (of course :-) "make -j bzImage" and
concurrent XMMS playing while my mail-client and mozilla are open, I cannot
"feel" a real big difference in interactivity compared to vanilla kernel. XMMS
hickups sometimes, mouse does kangaroo'ing, switching around different
X-screens and screen refresh (especially mozilla of course) are no big hit.

This is a dual PIII-1GHz/2 GB RAM and some swap. During make no swapping is
going on.

Sorry, but I cannot see (feel) the difference in _this_ test (if this is really
a test for what you intend to do). Compile time btw makes no difference either.
Perhaps this try is rather something for ingo and the scheduler...

Regards,
Stephan


