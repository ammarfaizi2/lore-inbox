Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264511AbRFOUSJ>; Fri, 15 Jun 2001 16:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264512AbRFOUSB>; Fri, 15 Jun 2001 16:18:01 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:38496
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S264511AbRFOURn>; Fri, 15 Jun 2001 16:17:43 -0400
Date: Fri, 15 Jun 2001 13:17:42 -0700
From: Larry McVoy <lm@bitmover.com>
To: Eugene Crosser <crosser@average.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 data corruption
Message-ID: <20010615131742.C27548@work.bitmover.com>
Mail-Followup-To: Eugene Crosser <crosser@average.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15Afvk-0005aV-00@the-village.bc.nu> <9gdp5c$pj$1@pccross.average.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <9gdp5c$pj$1@pccross.average.org>; from crosser@average.org on Fri, Jun 15, 2001 at 11:54:20PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001 at 11:54:20PM +0400, Eugene Crosser wrote:
> In article <E15Afvk-0005aV-00@the-village.bc.nu>,
>         Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> >> any problems since 2.4.5 was published, they seem to have surfaced
> >> immediately after I created a rather big file capturing video with
> >> broadcast2000 (video card is bt848).  Filesystem is ext2.
> > 
> > Thats something I've seen reported elsehwere. The high bandwidth capture card
> > stuff seems to show up problems. It could be drivers could be hardware. On
> > my AMD 751 pre release board I see that problem but on the 751 production board
> > I dont
> 
> You must be right, today I created another big file with the same program
> but without doing caputre and the filesystem was intact.  OTOH,
> Russell Leighton reports curruption when creating a file with dd...

For what it is worth, after having three failures in a row, now it isn't
happening.  My test case is/was my nightly backup.  If it happens again,
I'll save the corrupted data so we can do more digging.  I'm kicking 
myself for not having done it the first time around.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
