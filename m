Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUAVAF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 19:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUAVAF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 19:05:27 -0500
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:7629 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264283AbUAVAFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 19:05:18 -0500
From: Christian Unger <chakkerz@optusnet.com.au>
Reply-To: chakkerz@optusnet.com.au
Organization: naiv.sourceforge.net
To: Paul Misner <paul@misner.org>
Subject: Re: Nvidia drivers and 2.6.x kernel
Date: Thu, 22 Jan 2004 11:05:12 +1100
User-Agent: KMail/1.5.4
References: <200401221012.17121.chakkerz@optusnet.com.au> <200401211744.04064.paul@misner.org>
In-Reply-To: <200401211744.04064.paul@misner.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401221105.12148.chakkerz@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About module-init-tools ... dunno ... never heard of it, I'm on Slackware 9.1 
so ... dunno ... Not sure. But like you say, if i could not initalize modules 
the nvidia module should be the least of my worries, plus everything loads in 
2.4.22

>
> What messages do you get about what is going wrong?  What happens when you
> so a modprobe nvidia?  What does your log file from XFree show?
on make install i get:
FATAL: Error inserting nvidia (/lib/modules/2.6.1/kernel/drivers/video/
nvidia.ko): Invalid module format

That's the same thing that modprobe nvidia gets. 
I'll check the nv thing out.

One interesting error / warning i get during boot is this (from /var/log/
syslog) :
Jan 22 10:43:08 stormcrow kernel: nvidia: version magic '2.6.1 preempt K7 
gcc-3.2' should be '2.6.1 preempt K7 gcc-3.3'
Jan 22 10:46:15 stormcrow kernel: nvidia: version magic '2.6.1 preempt K7 
gcc-3.2' should be '2.6.1 preempt K7 gcc-3.3'

Not sure what to make of this. I know that 4496 had issues with the gcc 
version i was running a while backed, and i had to hack the installer script 
to ignore that (though i'm sure there is a switch for this stuff ... i was 
over reading at that point).

As for the XFree log ... i don't have that one ...

-- 
with kind regards,
  Christian Unger

"You don't need eyes to see, you need vision" (Faithless - Reverence)

  Mobile:            0402 268904
  Internet:          http://naiv.sourceforge.net
  NAIV Status:
     Stable       Testing       Development
      0.2.3r2      0.3.0         0.3.1 - File Handling

"May there be mercy on man and machine for their sins" (Animatrix)

