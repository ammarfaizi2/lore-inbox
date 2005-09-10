Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVIJMeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVIJMeT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVIJMeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:34:19 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:46859 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S1750797AbVIJMeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:34:18 -0400
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
References: <20050909214542.GA29200@kroah.com> <4322A160.1060809@gmail.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Sat, 10 Sep 2005 08:32:28 -0400
In-Reply-To: <4322A160.1060809@gmail.com> (Michael Thonke's message of "Sat, 10 Sep 2005 11:03:28 +0200")
Message-ID: <m2oe71cdcz.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke <iogl64nx@gmail.com> writes:

>>Here are the same "delete devfs" patches that I submitted for 2.6.12.
>>It rips out all of devfs from the kernel and ends up saving a lot of
>>space.  Since 2.6.13 came out, I have seen no complaints about the fact
>>that devfs was not able to be enabled anymore, and in fact, a lot of
>>different subsystems have already been deleting devfs support for a
>>while now, with apparently no complaints (due to the lack of users.)
>>  
>>
> How could users really say/complain what brakage they have, in fact they
> don't even know the relationship between all that
> ( e.g drivers -> devfs -> sysfs or other programs that rely on devfs)?

If you don't know that stuff, or aren't willing to learn and report
bugs, don't run a kernel.org kernel--stick with your distro.

> Devfs is in for many years, why removing it in just some weeks?

It's been slated for removal for quite a while, and it was completely
disabled in the last kernel release.

-Doug
