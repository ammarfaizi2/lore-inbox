Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136563AbREAC1Q>; Mon, 30 Apr 2001 22:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136564AbREAC1G>; Mon, 30 Apr 2001 22:27:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:56333 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S136563AbREAC06>;
	Mon, 30 Apr 2001 22:26:58 -0400
Date: Mon, 30 Apr 2001 23:26:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac1
In-Reply-To: <E14uOO0-0000pT-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0104302323540.19012-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Alan Cox wrote:

> This release is mostly meant for further eyes to check for merge
> errors. It boots but thats about all I'd guarantee. I plan to do just
> the fixups for 2.4.4 bugs and then back out some of the existing
> changes that don't help much - notably some of the VM tuning isnt
> gaining us anything but multiple bad implementations.

Later this week I'll have some time to look at the VM things
again. I suspect a lot of the code that was merged into the
-ac kernels either only helped one specific test case by
accident or only works if you think about it from the "right"
point of view ;)

One thing I've noted with many of the VM patches for 2.4 is
that the author goes into great detail describing a VM problem
that occurs and then attaches a patch which "fixes" something
only losely related to the problem described...  ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

