Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272522AbRIPQd4>; Sun, 16 Sep 2001 12:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272527AbRIPQdr>; Sun, 16 Sep 2001 12:33:47 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:61704 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272522AbRIPQd1>;
	Sun, 16 Sep 2001 12:33:27 -0400
Date: Sun, 16 Sep 2001 13:33:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: Ricardo Galli <gallir@m3d.uib.es>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <1000653836.2440.0.camel@gromit.house>
Message-ID: <Pine.LNX.4.33L.0109161330000.9536-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Sep 2001, Michael Rothwell wrote:

> Is there a way to tell the VM to prune its cache? Or a way to limit
> the amount of cache it uses?

Not yet, I'll make a quick hack for this when I get back next
week. It's pretty obvious now that the 2.4 kernel cannot get
enough information to select the right pages to evict from
memory.

For 2.5 I'm making a VM subsystem with reverse mappings, the
first iterations are giving very sweet performance so I will
continue with this project regardless of what other kernel
hackers might say ;)

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

