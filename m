Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317778AbSGZPZS>; Fri, 26 Jul 2002 11:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317782AbSGZPZS>; Fri, 26 Jul 2002 11:25:18 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47890 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317778AbSGZPZR>; Fri, 26 Jul 2002 11:25:17 -0400
Date: Fri, 26 Jul 2002 12:27:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
cc: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu
In-Reply-To: <20020726204033.D18570@in.ibm.com>
Message-ID: <Pine.LNX.4.44L.0207261225160.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002, Ravikiran G Thirumalai wrote:

> Rik, You were interested in using this.  Does this implementation suit
> your needs?

>From a quick glance it looks like it will.

However, it might be more efficient to put the statistics
in one file in /proc with named fields, or have a way to
group them in one or multiple files.

Not sure about that, though ... really depends on how
expensive stat+open+read+close is compared to parsing a
file with multiple fields.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

