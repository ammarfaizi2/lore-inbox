Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTDWWX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTDWWX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:23:27 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:52452 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264268AbTDWWX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:23:26 -0400
Message-ID: <3EA71533.4090008@suwalski.net>
Date: Wed, 23 Apr 2003 18:35:31 -0400
From: Pat Suwalski <pat@suwalski.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030331
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthias Schniedermeyer <ms@citd.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net> <20030423221749.GA9187@elf.ucw.cz>
In-Reply-To: <20030423221749.GA9187@elf.ucw.cz>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I expect kernel to just work, and not need 1001 tools to set it
> up. cat /bin/bash > /dev/dsp should produce some noise...

Without making a big point of it, I do believe that is the motivation 
behind ALSA.

I have used mixers for ALSA, OSS, esd, and artsd. If there is one set of 
tools for ALSA, that is a Good Thing.

Look at any other OS. There are not four individual mixers.


It should start at zero, then when you set the correct volume, it should 
remember it so that you can cat > /dev/dsp and have noise.

The alternative approach is to set the volume very low, but still 
perceptible by default, say 10% or 20%, so that the user is aware of his 
device working, then can set the mixer to a level that is good, which 
the system remembers.

--Pat

