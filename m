Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264237AbRFHRDS>; Fri, 8 Jun 2001 13:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264240AbRFHRDJ>; Fri, 8 Jun 2001 13:03:09 -0400
Received: from www.wen-online.de ([212.223.88.39]:15876 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264237AbRFHRDC>;
	Fri, 8 Jun 2001 13:03:02 -0400
Date: Fri, 8 Jun 2001 19:01:04 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: John Stoffel <stoffel@casc.com>
cc: Tobias Ringstrom <tori@unhappy.mine.nu>,
        Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <15136.62579.588726.954053@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.33.0106081853400.418-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, John Stoffel wrote:

> >>>>> "Tobias" == Tobias Ringstrom <tori@unhappy.mine.nu> writes:
>
> Tobias> On Fri, 8 Jun 2001, Mike Galbraith wrote:
>
> >> I gave this a shot at my favorite vm beater test (make -j30 bzImage)
> >> while testing some other stuff today.
>
> Tobias> Could you please explain what is good about this test?  I
> Tobias> understand that it will stress the VM, but will it do so in a
> Tobias> realistic and relevant way?
>
> I agree, this isn't really a good test case.  I'd rather see what
> happens when you fire up a gimp session to edit an image which is
> *almost* the size of RAM, or even just 50% the size of ram.  Then how
> does that affect your other processes that are running at the same
> time?

OK, riddle me this.  If this test is a crummy test, just how is it
that I was able to warn Rik in advance that when 2.4.5 was released,
he should expect complaints?  How did I _know_ that?  The answer is
that I fiddle with Rik's code a lot, and I test with this test because
it tells me a lot.  It may not tell you anything, but it does me.

	-Mike

