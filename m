Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRIFMrG>; Thu, 6 Sep 2001 08:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270523AbRIFMq4>; Thu, 6 Sep 2001 08:46:56 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:1037 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270619AbRIFMqs>; Thu, 6 Sep 2001 08:46:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Thu, 6 Sep 2001 14:53:58 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0109060930580.31200-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109060930580.31200-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010906124700Z16067-32383+3773@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 6, 2001 02:32 pm, Rik van Riel wrote:
> > > Lets face it, spinning the washing machine is expensive
> > > and running less than a full load makes things inefficient ;)
> >
> > That makes a good sound bite but doesn't stand up to scrutiny.
> > It's not a washing machine ;-)
> 
> Two words:  "IO clustering".

Yes, *after* the IO queue is fully loaded that makes sense.  Leaving it 
partly or fully idle while waiting for it to load up makes no sense at all.

IO clustering will happen naturally after the queue loads up.

--
Daniel
