Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289825AbSAKBrr>; Thu, 10 Jan 2002 20:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289827AbSAKBrj>; Thu, 10 Jan 2002 20:47:39 -0500
Received: from mail.shorewall.net ([206.124.146.177]:18693 "HELO
	mail.shorewall.net") by vger.kernel.org with SMTP
	id <S289825AbSAKBrd> convert rfc822-to-8bit; Thu, 10 Jan 2002 20:47:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tom Eastep <teastep@shorewall.net>
To: acrimon.beet@gmx.co.uk, linux-kernel@vger.kernel.org
Subject: Re: via sound acting very dodgy
Date: Thu, 10 Jan 2002 17:47:32 -0800
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020111005935.C5983@x.nat>
In-Reply-To: <20020111005935.C5983@x.nat>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020111014732.74403ACF6@mail.shorewall.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 January 2002 04:59 pm, acrimon.beet@gmx.co.uk wrote:

>
> kernel: Assertion failed! chan->is_active ==
> sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1198
>
> At the moment I'm pretty much assuming I've got broken hardware, but
> I'd be interested to know if there are any known problems with
> the driver.

FWIW, I'm seeing the same message after which any attempt to play any sound 
simply hangs (with an additional instance of the message). Unloading all 
sound-related modules and reloaded them doesn't help and I end up rebooting 
to clear the problem. I'm only running into this about once per week so it's 
more of a nuisance than anything else. 

-Tom
-- 
Tom Eastep    \ A Firewall for Linux 2.4.*
AIM: tmeastep  \ http://www.shorewall.net
ICQ: #60745924  \ teastep@shorewall.net
-------------------------------------------
