Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270797AbRIFQ60>; Thu, 6 Sep 2001 12:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270823AbRIFQ6L>; Thu, 6 Sep 2001 12:58:11 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:50949 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270797AbRIFQ5k>;
	Thu, 6 Sep 2001 12:57:40 -0400
Date: Thu, 6 Sep 2001 13:57:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Kurt Garloff <garloff@suse.de>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010906163937Z16125-26183+11@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0109061356280.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Daniel Phillips wrote:

> Err, not quite the whole story.  It is *never* right to leave the disk
> sitting idle while there are dirty, writable IO buffers.

Define "idle" ?

Is idle the time it takes between two readahead requests
to be issued, delaying the second request because you
just moved the disk arm away ?

Is idle when we haven't had a request for, say, 3 disk
seek time periods ?

Is idle when we won't be getting any request soon for the
area where the disk arm is hanging out ?  (and how do we
know the future?)

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

