Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265029AbSJWP2r>; Wed, 23 Oct 2002 11:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSJWP2r>; Wed, 23 Oct 2002 11:28:47 -0400
Received: from 86.33.202.62.dial.bluewin.ch ([62.202.33.86]:12688 "EHLO
	k3.hellgate.ch") by vger.kernel.org with ESMTP id <S265029AbSJWP2p>;
	Wed, 23 Oct 2002 11:28:45 -0400
Date: Wed, 23 Oct 2002 17:34:53 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-rhine weirdness with via kt8235 Southbridge
Message-ID: <20021023153453.GA12338@k3.hellgate.ch>
Mail-Followup-To: Christian Guggenberger <christian.guggenberger@physik.uni-regensburg.de>,
	linux-kernel@vger.kernel.org
References: <20021023154824.C14930@pc9391.uni-regensburg.de> <20021023154931.E14930@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021023154931.E14930@pc9391.uni-regensburg.de>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.44 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002 15:49:31 +0200, Christian Guggenberger wrote:
> This concerns both 2.4 and 2.5 kernels  (testet with 2.4.20pre*aa series,
> and with 2.5.43, 2.5.44 and 2.5.44-ac1):
> 
> When I enable APIC in the Bios, the via-rhine module will insert
> properly, but I won't get a link... With APIC disabled, link is ok.  Ok,
> this could be caused by buggy bios, so I'll try again, when a new
> biosversion is available.

Yeah, it seems there's a problem with IO-APICs. I currently don't have a
machine with IO-APIC for testing, though, so...

> 2.
> This only happens with the 2.5 series (testet with 2.5.43 and above):

2.5 is carrying an old version of the driver. I will post an update with
additional fixes for both 2.4 and 2.5 before it's 2.6 :-).

Roger
