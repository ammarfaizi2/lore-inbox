Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318782AbSHWMWs>; Fri, 23 Aug 2002 08:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318784AbSHWMWs>; Fri, 23 Aug 2002 08:22:48 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:31247 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318782AbSHWMWr>; Fri, 23 Aug 2002 08:22:47 -0400
Date: Fri, 23 Aug 2002 09:26:42 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: ic@aleph1.net
cc: linux-kernel@vger.kernel.org
Subject: Re: process 0
In-Reply-To: <20020823121115.GA31534@aleph1.net>
Message-ID: <Pine.LNX.4.44L.0208230926150.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002 ic@aleph1.net wrote:

> Maybe this is a little off topic, but does what is the real status of
> Process 0 (swapper) ?
> Some people keep telling me it doesn't exist, but on some kernel crashes
> I can see "process swapper (pid 0, process nr 0, ...)"

It's the idle task.  Only exists to keep the CPU occupied when
nothing else wants to run.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

