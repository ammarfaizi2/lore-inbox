Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288331AbSAHVJq>; Tue, 8 Jan 2002 16:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288351AbSAHVJb>; Tue, 8 Jan 2002 16:09:31 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:29713 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288331AbSAHVIp>;
	Tue, 8 Jan 2002 16:08:45 -0500
Date: Tue, 8 Jan 2002 19:08:13 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16O3L5-0000B8-00@starship.berlin>
Message-ID: <Pine.LNX.4.33L.0201081907040.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Daniel Phillips wrote:

> The preemptible kernel can reschedule, on average, sooner than the
> scheduling-point kernel, which has to wait for a scheduling point to
> roll around.

The preemptible kernel ALSO has to wait for a scheduling point
to roll around, since it cannot preempt with spinlocks held.

Considering this, I don't see much of an advantage to adding
kernel preemption.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

