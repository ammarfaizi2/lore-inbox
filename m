Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268199AbRHOXXx>; Wed, 15 Aug 2001 19:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268434AbRHOXXo>; Wed, 15 Aug 2001 19:23:44 -0400
Received: from adonis.lbl.gov ([128.3.5.144]:1554 "EHLO adonis.lbl.gov")
	by vger.kernel.org with ESMTP id <S268199AbRHOXXf>;
	Wed, 15 Aug 2001 19:23:35 -0400
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: Re: Dell I8000, 2.4.8-ac5 and APM
In-Reply-To: <997911115.7088.4.camel@keller> <29219.997909757@redhat.com>
	<30038.997911777@redhat.com> <3B7AF05C.29521C46@zip.com.au>
	<9lev5u$1kl$1@picard.cistron.nl>
From: Alex Romosan <romosan@adonis.lbl.gov>
Date: 15 Aug 2001 16:23:42 -0700
In-Reply-To: <9lev5u$1kl$1@picard.cistron.nl> (wichert@cistron.nl)
Message-ID: <87hev8kiv5.fsf@adonis.lbl.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wichert@cistron.nl (Wichert Akkerman) writes:

> In article <3B7AF05C.29521C46@zip.com.au>,
> Andrew Morton  <akpm@zip.com.au> wrote:
> >I occasionally hear rumours about 3c59x failing with suspend/resume,
> >but It Works For Me and nobody has stepped up with a solid problem
> >description.  If someone _can_ reproduce this and is prepared to
> >work it a bit, please let me know.
> 
> I can reproduce it reliably. 3c575 pcmcia card using 3c59x driver. 
> Works fine until you suspend, and after a resume it no longer works
> until you pop it out and reinsert it.
> 
> If you want anything tested let me know.
> 

i see the same thing with linus' 2.4.x kernels (including 2.4.9-pre4).
it used to work for a while but then it stopped. what i find strange
is that if i am connected to a 10BaseT network it comes as 100BaseT
and vice versa. some logic is screwed up in the resume code i think
(on startup it works fine). this happens all the time. i am willing to
test patches if you have any.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
