Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284785AbRLKBfj>; Mon, 10 Dec 2001 20:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284780AbRLKBfT>; Mon, 10 Dec 2001 20:35:19 -0500
Received: from cx662584-g.okcnc1.ok.home.com ([24.254.203.6]:46743 "HELO
	cx662584-g.oknc1.ok.home.com") by vger.kernel.org with SMTP
	id <S284781AbRLKBfR>; Mon, 10 Dec 2001 20:35:17 -0500
Subject: Re: [PATCH] Make highly niced processes run only when idle
From: Steve Bergman <steve@rueb.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1007944229.878.21.camel@phantasy>
In-Reply-To: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org>
	<1007939114.878.1.camel@phantasy> <20011209181643.A8846@redhat.com>
	<1007940066.878.7.camel@phantasy>  <20011209184656.E8846@redhat.com> 
	<1007944229.878.21.camel@phantasy>
X-Mailer: Evolution/0.13 (Preview Release)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 10 Dec 2001 19:35:16 -0600
Message-Id: <1008034516.1454.16.camel@cx662584-f.oknc1.ok.home.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not a kernel hacker by any stretch of the imagination but I do
follow lkml.  While SCHED_IDLE would be really nice it seems like this
topic comes up from time to time there always seems to be a (deadlock)
catch that keeps it from getting into the main kernel tree.  While it
would be really great if Robert's patch turns out to be the magic bullet
this time, as a Linux user and SetiAtHome supporter I would be happy
just to have a "nice -19" that was truly nice.  Running setiathome at
nice -19 on my box and then firing up a processor intensive process at
normal priority, I find that seti still uses 14% processor according to
top.  I like to run 2 setiathome processes because I get better overall
throughput that way, but the 2 combined then get ~25% of the processor.
Not really all that nice.  Would it be difficult to make "19" a special
case that was really, really nice, but not *totally* nice?  Avoiding
deadlock but still following the spirit of SCHED_IDLE?  




