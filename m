Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271688AbTGXPTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 11:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271690AbTGXPTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 11:19:09 -0400
Received: from gw-nl6.philips.com ([212.153.235.103]:43140 "EHLO
	gw-nl6.philips.com") by vger.kernel.org with ESMTP id S271688AbTGXPSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 11:18:41 -0400
Message-ID: <3F1FFC94.7080409@basmevissen.nl>
Date: Thu, 24 Jul 2003 17:34:44 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain> <1059058737.7994.25.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1059058737.7994.25.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> 
> So someone coming from 2.4 can fix it when they need it. You can tag
> such things with && OBSOLETE, we did that in 2.4.
> 

Is this something for the kernel config? Just below CONFIG_EXPERIMENTEL 
in the menu, add CONFIG_OBSOLETE. The 'make allyesconfig' and the like 
can ignore experimental and obsolete stuff.

This would make a reasonable Q-requirement for 2.6.0 that at least the 
kernel compiles with 'make allyesconfig'. The only thing open is to 
decide what is obsolete and what not (and needs fix). That is not 
trivial. IMHO, Linus some time ago had a good statement about it, but it 
is somewhat hard to see how long something is broken from the code alone :-)

If this is a good idea, I'll supply a patch for 2.6.0-something with at 
least some non-compiling stuff marked obsolete.

Regards,

Bas.



