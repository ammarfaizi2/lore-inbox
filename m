Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVACAWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVACAWo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVACAWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:22:44 -0500
Received: from holomorphy.com ([207.189.100.168]:52886 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261352AbVACAWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:22:41 -0500
Date: Sun, 2 Jan 2005 16:19:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: William Lee Irwin III <wli@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103001917.GO29332@holomorphy.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <20050102214211.GM29332@holomorphy.com> <20050102221534.GG4183@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102221534.GG4183@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 01:42:11PM -0800, William Lee Irwin III wrote:
>> This is not optimism. This is experience. Every ``stable'' kernel I've
>> seen is a pile of incredibly stale code where vi'ing any file in it
>> instantly reveals numerous months or years old bugs fixed upstream.
>> What is gained in terms of reducing the risk of regressions is more
>> than lost by the loss of critical examination and by a long longshot.

On Sun, Jan 02, 2005 at 11:15:34PM +0100, Adrian Bunk wrote:
> The main advantage with stable kernels in the good old days (tm) when 4 
> and 6 were even numbers was that you knew if something didn't work, and 
> upgrading to a new kernel inside this stable kernel series had a 
> relatively low risk of new breakages. This meant one big migration every 
> few years and relatively easy upgrades between stable series kernels.

This never saved anyone any pain. 2.4.x was not the stable kernel
you're painting it to be until 2.4.20 or later, and by the time it
became so the fixes for major regressions that occurred during 2.3.x
were deemphasized and ignored for anything prior to 2.6.x.


On Sun, Jan 02, 2005 at 11:15:34PM +0100, Adrian Bunk wrote:
> Nowadays in 2.6, every new 2.6 kernel has several regressions compared 
> to the previous one, and additionally obsolete but used code like 
> ipchains and devfs is scheduled for removal making upgrades even harder 
> for many users.

My experience tells me that the number of regressions in 2.6.x compared
to purportedly ``far stabler'' kernels is about the same or (gasp!)
less. So the observable advantage of the ``frozen'' or ``stable'' model
is less than or equal to zero.

Frankly, kernel hacking is a difficult enough task (not that I
personally find it so) that frivolous patches are not overwhemingly
numerous. The ``barrier'' you're erecting is primarily acting as a
barrier to fixes, not bugs.


On Sun, Jan 02, 2005 at 11:15:34PM +0100, Adrian Bunk wrote:
> There's the point that most users should use distribution kernels, but 
> consider e.g. that there are poor souls with new hardware not supported 
> by the 3 years old 2.4.18 kernel in the stable part of your Debian 
> distribution.

Again, the loss of critical examination far outweighs the purported
defense against regressions. The most typical result of playing the fix
backporting game for extended periods of time is numerous rounds of
months-long bughunts for bugs whose fixes were merged years ago upstream.
When the bugs are at long last found, they are discovered to fix the
problems of hundreds of users until the next such problem surfaces.


-- wli
