Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275813AbRJYSCu>; Thu, 25 Oct 2001 14:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275822AbRJYSCl>; Thu, 25 Oct 2001 14:02:41 -0400
Received: from newssvr17-ext.news.prodigy.com ([207.115.63.157]:52864 "EHLO
	newssvr17.news.prodigy.com") by vger.kernel.org with ESMTP
	id <S275813AbRJYSCX>; Thu, 25 Oct 2001 14:02:23 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
Newsgroups: linux.dev.kernel
Subject: Re: 2.4.12 cannot find root device on raid
In-Reply-To: <15319.38517.663820.504760@notabene.cse.unsw.edu.au>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: davidsen@deathstar.prodigy.com (Bill Davidsen)
Message-ID: <htYB7.5102$d%.933992639@newssvr17.news.prodigy.com>
NNTP-Posting-Host: 192.168.192.240
X-Complaints-To: abuse@prodigy.net
X-Trace: newssvr17.news.prodigy.com 1004032973 000 192.168.192.240 (Thu, 25 Oct 2001 14:02:53 EDT)
NNTP-Posting-Date: Thu, 25 Oct 2001 14:02:53 EDT
Date: Thu, 25 Oct 2001 18:02:53 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <15319.38517.663820.504760@notabene.cse.unsw.edu.au>,
Neil Brown <neilb@cse.unsw.edu.au> wrote:
| On Tuesday October 23, davidsen@prodigy.com wrote:
| > 
| > The line you provide doesn't look anything like the two forms in the
| > md.txt you mention. Or rather it looks like a blending, but neither of
| > them is md0= in form. I have to look at the code to see which is
| > correct, possibly yours, since the 
| >   append = "md=0,/dev/sda1,/dev/sdb1"
| > line doesn't seem to work :-(
| 
| Odd ... I use lines just like that. e.g.:
|    append="md=0,/dev/hda1,/dev/hde1,/dev/hdg1"
| 
| and it works just fine.  What do you get in the way of error messages?

None - the system simply exits the BIOS, reads the first drive once and
cold boots. The drive is okay, I can read both copies of the mirror end
to end without error after booting from floppy. Lilo claims it writes to
the md0 device, but boot fails.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
