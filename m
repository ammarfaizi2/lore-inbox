Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRDYRij>; Wed, 25 Apr 2001 13:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130900AbRDYRi3>; Wed, 25 Apr 2001 13:38:29 -0400
Received: from china.patternbook.com ([216.254.75.60]:36345 "EHLO
	free.transpect.com") by vger.kernel.org with ESMTP
	id <S130487AbRDYRiN>; Wed, 25 Apr 2001 13:38:13 -0400
Date: Wed, 25 Apr 2001 13:38:04 -0500
From: Whit Blauvelt <whit@transpect.com>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 Realaudio masq problem
Message-ID: <20010425133804.A1094@free.transpect.com>
In-Reply-To: <20010424201403.A1909@free.transpect.com> <3AE621D1.FE45602B@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE621D1.FE45602B@bigfoot.com>; from timothymoore@bigfoot.com on Tue, Apr 24, 2001 at 06:01:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 06:01:05PM -0700, Tim Moore wrote:

> rtsp://rm.on24.com/media/news/04192001/palumbo_ted6.rm
> --stop--
> http://rm.on24.com/media/news/04192001/palumbo_ted6.rm

Hmm, the rtsp: fails while the http: works for that one. But then a tcp
connection doesn't depend on the realaudio masq module.

> Try '# strace /usr/bin/X11/realplay On24ram.asp > log' and see where the
> connect fails if you aren't getting specific error messages.

Unfortunately this spits out a bunch of stuff and then totally freezes up my
KDE 2.1.1 desktop. Probably totally unrelated, but that's what happens - the
part of the log that ends up in the frozen display doesn't tell me much, and
have to go to shell and kill strace to unfreeze things.

Could the problem be that I have realplay 8.0.3.412 on the systems here and
they've introduced some bug or incompatibility?

Whit


