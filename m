Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTDXNhQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbTDXNhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:37:16 -0400
Received: from pdbn-d9bb8734.pool.mediaWays.net ([217.187.135.52]:6922 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S263638AbTDXNhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:37:14 -0400
Date: Thu, 24 Apr 2003 15:49:04 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Werner Almesberger <wa@almesberger.net>
Cc: Jamie Lokier <jamie@shareable.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424134904.GA18149@citd.de>
References: <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424103858.M3557@almesberger.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:38:58AM -0300, Werner Almesberger wrote:
> Jamie Lokier wrote:
> > Yes, do make sure it is in there.
> 
> What's actually the exact statement ? Does anything change if you
> don't switch from OSS to ALSA ?
> 
> Would something like this be correct ?
> 
> 
> Sound
> =====
> 
> ALSA
> ----
> 
> ALSA (Advanced Linux Sound Architecture) is now the preferred
> architecture for sound support, instead of the older OSS (Open
> Sound System). Note that all volume settings default to zero
> in ALSA, so user space needs to explicitly increase the volume
> before any sound can be heard.

To be exact. ALSA mutes all channels, if you don't unset the mute-flags
on the channels you can increase the volume to 100% without a change.
:-)




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

