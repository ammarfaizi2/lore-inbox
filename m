Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275042AbRJYPku>; Thu, 25 Oct 2001 11:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275110AbRJYPkk>; Thu, 25 Oct 2001 11:40:40 -0400
Received: from newssvr17-ext.news.prodigy.com ([207.115.63.157]:55244 "EHLO
	newssvr17.news.prodigy.com") by vger.kernel.org with ESMTP
	id <S275042AbRJYPkb>; Thu, 25 Oct 2001 11:40:31 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
Newsgroups: linux.dev.kernel
Subject: Re: linux-2.4.12 / linux-2.4.13 parallel port problem
In-Reply-To: <20011024230917.H7544@redhat.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: davidsen@deathstar.prodigy.com (Bill Davidsen)
Message-ID: <ioWB7.5038$rR5.921319585@newssvr17.news.prodigy.com>
NNTP-Posting-Host: 192.168.192.240
X-Complaints-To: abuse@prodigy.net
X-Trace: newssvr17.news.prodigy.com 1004024462 000 192.168.192.240 (Thu, 25 Oct 2001 11:41:02 EDT)
NNTP-Posting-Date: Thu, 25 Oct 2001 11:41:02 EDT
Date: Thu, 25 Oct 2001 15:41:02 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011024230917.H7544@redhat.com>,
Tim Waugh <twaugh@redhat.com> wrote:

| On Wed, Oct 24, 2001 at 04:53:56PM +0100, Dave Garry wrote:
| 
| > modprobe verbose_probing=1 irq=7 gives exactly the same results.
| 
| This turned out to be because parport_pc ignores a supplied irq when
| no io parameter is also supplied.  'io=0x378 irq=7' works fine.

Thank you... that sure doesn't jump out at someone, it generates no
error message, etc.

Question: is this intended behaviour? I would think that you would
normally want to just say irq=auto and let the driver find the io
address just as it does normally.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
