Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272677AbRI0MoN>; Thu, 27 Sep 2001 08:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272717AbRI0MoD>; Thu, 27 Sep 2001 08:44:03 -0400
Received: from ns.suse.de ([213.95.15.193]:55309 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272677AbRI0Mn6>;
	Thu, 27 Sep 2001 08:43:58 -0400
Date: Thu, 27 Sep 2001 14:44:22 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Padraig Brady <padraig@antefacto.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU frequency shifting "problems"
In-Reply-To: <3BB319ED.5020406@antefacto.com>
Message-ID: <Pine.LNX.4.30.0109271437260.27486-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001, Padraig Brady wrote:

> >Does the C3 do any kind of frequency shifting?
> Not automatic, but you can set the multiplier dynamically by setting the
> msr.
> Russell King has been working on an arch independent framework for this
> kind of thing and support for the C3 has recently been added by Dave Jones.

If you're going to try this out on a C3 btw, heed the warning at the
top of the code :) This still needs quite a bit of work.
I just need to find the time to sit down and finish it.
(The x86 bits are all thats preventing Russell from saying
 "This is ready" iirc, so I should get that finished at some point soon)

I'd like to add Transmeta Longrun support to it too, but that can
come later, when I get access to one.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

