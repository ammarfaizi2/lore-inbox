Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318406AbSHBKjm>; Fri, 2 Aug 2002 06:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318565AbSHBKjm>; Fri, 2 Aug 2002 06:39:42 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:50165 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318406AbSHBKjl>; Fri, 2 Aug 2002 06:39:41 -0400
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for
	2.5.29)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@elf.ucw.cz>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
In-Reply-To: <20020802082443.GB12868@atrey.karlin.mff.cuni.cz>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> 
	<20020802082443.GB12868@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 12:59:47 +0100
Message-Id: <1028289587.18317.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 09:24, Pavel Machek wrote:
> Imagine DVD playback. If you have 2% error, your audio is going to get
> 1 second off each minute. It is going to be off by one minute at the
> end of hour. 2% is probably not acceptable.

Nobody does DVD synchronization off a timer. You synchronize the video
to the audio because if the audio clock is a bit off it doesnt matter,
if you lock the audio to the video you get nasty clicks and skips.

2% is way too much for a lot of applications. Thats 28 minutes a day


