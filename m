Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271958AbRIMSbG>; Thu, 13 Sep 2001 14:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271964AbRIMSaz>; Thu, 13 Sep 2001 14:30:55 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:47881 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S271958AbRIMSan>; Thu, 13 Sep 2001 14:30:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Phil Thompson <Phil.Thompson@pace.co.uk>
Subject: Re: User Space Emulation of Devices
Date: Thu, 13 Sep 2001 20:33:34 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC591@exchange1.cam.pace.co.uk>
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC591@exchange1.cam.pace.co.uk>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15hbFt-20fkmmC@fmrl05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 September 2001 10:25, Phil Thompson wrote:
> The best approach I found (for my purposes anyway) was the one used by the
> ALSA OSS emulator (and strace as well?) that uses weak & strong symbols in
> a pre-loaded shared library to intercept system calls to the device I
> wanted to handle in user space.
> I'd be surprised if this technique was suitable as a generic approach.

Unfortunately not for writing device drivers in user space because the 
library inherits the user id from the application - you have to be root to 
access hardware.

bye...

