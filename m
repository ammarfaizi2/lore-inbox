Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270253AbRIFNDS>; Thu, 6 Sep 2001 09:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270257AbRIFNDI>; Thu, 6 Sep 2001 09:03:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:17928 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270253AbRIFNC5>;
	Thu, 6 Sep 2001 09:02:57 -0400
Date: Thu, 6 Sep 2001 10:03:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010906124700Z16067-32383+3773@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0109061002050.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Daniel Phillips wrote:
> On September 6, 2001 02:32 pm, Rik van Riel wrote:

> > Two words:  "IO clustering".
>
> Yes, *after* the IO queue is fully loaded that makes sense.  Leaving it
> partly or fully idle while waiting for it to load up makes no sense at all.
>
> IO clustering will happen naturally after the queue loads up.

Exactly, so we need to give the queue some time to load
up, right ?

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

