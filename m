Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269770AbRHYQia>; Sat, 25 Aug 2001 12:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269763AbRHYQiU>; Sat, 25 Aug 2001 12:38:20 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:65038 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269770AbRHYQiB>; Sat, 25 Aug 2001 12:38:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sat, 25 Aug 2001 18:43:29 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
In-Reply-To: <Pine.LNX.4.33L.0108251249510.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108251249510.5646-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010825163648Z16186-32383+1334@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 25, 2001 05:50 pm, Rik van Riel wrote:
> On Sat, 25 Aug 2001, Daniel Phillips wrote:
> 
> > > True, it's just an issue of performance and heavily used
> > > servers falling over under load, nothing as serious as
> > > data corruption or system instability.
> >
> > If your server is falling over under load, this is not the reason.
> 
> I bet your opinion will be changed the moment you see a system
> get close to falling over exactly because of this.
> 
> Remember NL.linux.org a few weeks back, where a difference of
> 10 FTP users more or less was the difference between a system
> load of 3 and a system load of 250 ?  ;)

Well, lets look into that then.  Surely you hit the wall at some point, no 
matter which replacement policy you use.  How many simultaneous downloads can 
you handle with 2.4.7 vs 2.4.8?

--
Daniel
