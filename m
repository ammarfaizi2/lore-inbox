Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272661AbRIPSaS>; Sun, 16 Sep 2001 14:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272664AbRIPSaI>; Sun, 16 Sep 2001 14:30:08 -0400
Received: from ns.ithnet.com ([217.64.64.10]:9734 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272661AbRIPS3u>;
	Sun, 16 Sep 2001 14:29:50 -0400
Date: Sun, 16 Sep 2001 20:16:57 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ricardo Galli <gallir@m3d.uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-Id: <20010916201657.052b0fc0.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0109161856380.31311-100000@m3d.uib.es>
In-Reply-To: <Pine.LNX.4.33L.0109161330000.9536-100000@imladris.rielhome.conectiva>
	<Pine.LNX.4.33.0109161856380.31311-100000@m3d.uib.es>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001 19:06:45 +0200 (MET) Ricardo Galli <gallir@m3d.uib.es>
wrote:

> On Sun, 16 Sep 2001, Jeremy Zawodny wrote:
> >
> > Agreed. I'd be great if there was an option to say "Don't swap out
> > memory that was allocated by these programs. If you run out of disk
> > buffers, toss the oldest ones and start re-using them."
> 
> More easy though (for cases of listening mp3's and backups): cache pages
> that were accesed only "once"(*) several seconds ago must be discarded
> first. It only implies a check against an access counter and a "last
> accesed"  epoch fields of the page.

Well, I guess this is everybody's first idea about the problem: make an initial
timestamp for knowing how _old_ an allocation really is, and make an access
counter. Ok. The first is easy, but how do you achieve an access-counter? If
this was solved, the problem is solved.
You can do really nice aging with access to such kind of information.
Any ideas?

Regards,
Stephan

