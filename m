Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbTDWWnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTDWWnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:43:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31759 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264270AbTDWWnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:43:13 -0400
Date: Thu, 24 Apr 2003 00:55:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pat Suwalski <pat@suwalski.net>
Cc: Pavel Machek <pavel@ucw.cz>, Matthias Schniedermeyer <ms@citd.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030423225520.GA32577@atrey.karlin.mff.cuni.cz>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net> <20030423221749.GA9187@elf.ucw.cz> <3EA71533.4090008@suwalski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA71533.4090008@suwalski.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> >up. cat /bin/bash > /dev/dsp should produce some noise...
> 
> Without making a big point of it, I do believe that is the motivation 
> behind ALSA.
> 
> I have used mixers for ALSA, OSS, esd, and artsd. If there is one set of 
> tools for ALSA, that is a Good Thing.
> 
> Look at any other OS. There are not four individual mixers.
> 
> 
> It should start at zero, then when you set the correct volume, it should 
> remember it so that you can cat > /dev/dsp and have noise.

That breaks in init=/bin/bash siuations, old distros, etc.

> The alternative approach is to set the volume very low, but still 
> perceptible by default, say 10% or 20%, so that the user is aware of his 
> device working, then can set the mixer to a level that is good, which 
> the system remembers.

20% default level works for me. AAt least I know what the problem is
(hey, need to set up mixer).

						Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
