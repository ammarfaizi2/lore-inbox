Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283723AbRLWFsH>; Sun, 23 Dec 2001 00:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283720AbRLWFr5>; Sun, 23 Dec 2001 00:47:57 -0500
Received: from tierra.ucsd.edu ([132.239.214.132]:54441 "EHLO burn")
	by vger.kernel.org with ESMTP id <S283723AbRLWFro>;
	Sun, 23 Dec 2001 00:47:44 -0500
Date: Sat, 22 Dec 2001 21:46:30 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, billh@tierra.ucsd.edu,
        bcrl@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011222214630.B12352@burn.ucsd.edu>
In-Reply-To: <20011219.172046.08320763.davem@redhat.com> <E16HTTI-0000w0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16HTTI-0000w0-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 21, 2001 at 05:28:36PM +0000
From: Bill Huey <billh@tierra.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 05:28:36PM +0000, Alan Cox wrote:
> > Precisely, in fact.  Anyone who can say that Java is going to be
> > relevant in a few years time, with a straight face, is only kidding
> > themselves.
> 
> Oh it'll be very relevant. Its leaking into all sorts of embedded uses, from
> Digital TV to smartcards. Its still useless for serious high end work an
> likely to stay so.
> 
> > Java is not something to justify a new kernel feature, that is for
> > certain.
> 
> There we agree. Things like the current asynch/thread mess in java are
> partly poor design of language and greatly stupid design of JVM.

It's not the fault of the JVM runtime nor the the language per se since
both are excellent. The blame should instead be placed on the political
process within Sun, which has created a lag in getting a decent IO event
model/system available in the form of an API.

This newer system is suppose to be able to scale to tens of thousands of
FDs and be able to handle heavy duty server side stuff in a more graceful
manner. It's a reasonable system from what I saw, but the implementation
of it is highly OS dependent and will be subject to those environmental
constraints. Couple this and the HotSpot compiler (supposeablly competitive
with gcc's -O3 from benchmarks) and it should be high useable for a broad
range of of server side work when intelligently engineered.  

bill

