Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVFGUR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVFGUR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVFGUR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:17:26 -0400
Received: from smtp1.rz.uni-karlsruhe.de ([129.13.185.217]:19869 "EHLO
	smtp1.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S261947AbVFGURW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:17:22 -0400
Message-ID: <42A600CD.6090408@web.de>
Date: Tue, 07 Jun 2005 22:17:17 +0200
From: Christian Trefzer <ctrefzer@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050514)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fdomain SCSI driver broken in 2.6 series?
References: <429AFA40.3010705@web.de> <1118161118.26661.19.camel@localhost.localdomain>
In-Reply-To: <1118161118.26661.19.camel@localhost.localdomain>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> I did a bit of cleanup on it during 2.5 to get it to compile and look
> right, and it did work for a while when I had the card, but the scsi
> changed a lot after that. You are the first fdomain user I've seen in
> years so I suspect you are on your own for fixing it too tho I can try
> and help a bit.
> 
Guess I'm the only person insane enough to try and build a DSL router 
based on 2.6 with ancient SCSI disks on an ISA controller, but I just 
can't live without some of the features anymore which 2.4 still lacks.

In the meantime, I worked around the Oops by using a tiny disk on the 
onboard IDE controller, but I wouldn't quite call removing the card a 
fix for the problem.

The thing is, I have no real experience in C programming, although I 
sometimes read a little kernel source code and stuff. Right now I have a 
bit of trouble with my studies, but once that's settled I can do some 
reading about SCSI, Linux, the works. Doesn't seem to be anyone using 
2.6 with Future Domain cards anyway, so I'm not in a hurry. But just for 
completeness, it would be nice to have that driver cleaned up. It's in 
Linux' tree, after all. I'll build a testing box with ISA bus some time 
soon and try some debugging.

Thanks for your time : )
