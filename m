Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265405AbRGCRTM>; Tue, 3 Jul 2001 13:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRGCRTC>; Tue, 3 Jul 2001 13:19:02 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:26118 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265405AbRGCRS7>; Tue, 3 Jul 2001 13:18:59 -0400
Date: Tue, 3 Jul 2001 12:46:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Removal of PG_marker scheme from 2.4.6-pre
In-Reply-To: <Pine.LNX.4.33L.0107012301460.19985-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0107031245590.2868-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Jul 2001, Rik van Riel wrote:

> On Sat, 30 Jun 2001, Marcelo Tosatti wrote:
> 
> > In pre7:
> >
> > "me: undo page_launder() LRU changes, they have nasty side effects"
> >
> > Can you be more verbose about this ?
> 
> I think this was fixed by the GFP_BUFFER vs. GFP_CAN_FS + GFP_CAN_IO
> thing and Linus accidentally backed out the wrong code ;)
> 
> cheers,
> Rik

Nope.

-ac also freezes and it does not have the GFP_BUFFER changes. 

