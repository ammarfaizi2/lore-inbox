Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288102AbSBRWMr>; Mon, 18 Feb 2002 17:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288174AbSBRWMi>; Mon, 18 Feb 2002 17:12:38 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:8964 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S288102AbSBRWMb>; Mon, 18 Feb 2002 17:12:31 -0500
Date: Mon, 18 Feb 2002 23:12:29 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Oliver Hillmann <oh@novaville.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <Pine.LNX.4.10.10202182040260.11179-100000@rimini.novaville.de>
Message-ID: <Pine.LNX.4.33.0202182305390.10354-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Oliver Hillmann wrote:

> Hello,
> 
> yes, I know this is defenitely no new issue (maybe its none to you
> anyway), since I found posts about this dating from 1998: the
> jiffies counter rolls over after approx. 497 days uptime, which
> causes the uptime to roll over as well, and seems to cause some
> other irretation in the system itself (my pc speaker starting
> beeping constantely...)

See 
http://www.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-47/0736.html
for a patch.
I intend to submit this for 2.4.19pre after some more testing and 
feedback.

Also note that several patches for jiffies rollover bugs have gone into 
2.4.18pre, maybe one of them fixes the speaker driver.

Tim

