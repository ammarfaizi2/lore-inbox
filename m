Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUGGIy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUGGIy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 04:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264998AbUGGIy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 04:54:57 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:22030 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S264984AbUGGIy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 04:54:56 -0400
From: Meelis Roos <mroos@linux.ee>
To: jesse@cola.voip.idv.tw, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7+BK bad: scheduling while atomic! (ALSA?)
In-Reply-To: <1089168049.3892.19.camel@libra>
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.7 (i686))
Message-Id: <E1Bi8BA-0006m2-62@rhn.tartu-labor>
Date: Wed, 07 Jul 2004 11:53:24 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WcJS> I got similar output here when I try to run xmms with alsa plugin.
WcJS> Solved with modified sound/core/control.c. Maybe you can try this tiny
WcJS> patch. :)

This works, thanks! alsamixer no longer segfaults on exit.

I actually had 2 problems, the other one being xruns with snd_via82xx
driver and these are still present.

-- 
Meelis Roos
