Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTEJDWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 23:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTEJDWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 23:22:53 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:43146 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261890AbTEJDWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 23:22:52 -0400
Date: Sat, 10 May 2003 13:35:04 +1000
From: CaT <cat@zip.com.au>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use correct x86 reboot vector
Message-ID: <20030510033504.GA1789@zip.com.au>
References: <20030510025634.GA31713@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510025634.GA31713@averell>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 04:56:34AM +0200, Andi Kleen wrote:
> Extensive discussion by various experts on the discuss@x86-64.org
> mailing list concluded that the correct vector to restart an 286+ 
> CPU is f000:fff0, not ffff:0000. Both seem to work on current systems, 
> but the first is correct.

Could this bug, by any chance, cause a system to shutdown instead of
rebooting? This is what happens to me at the moment but not each and
every time.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
