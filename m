Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWITOxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWITOxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 10:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWITOxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 10:53:41 -0400
Received: from aun.it.uu.se ([130.238.12.36]:22732 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751553AbWITOxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 10:53:41 -0400
Date: Wed, 20 Sep 2006 16:52:35 +0200 (MEST)
Message-Id: <200609201452.k8KEqZBp014384@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: jeff@garzik.org, w@1wt.eu
Subject: Re: 2.4.x libata resync
Cc: htejun@gmail.com, linux-kernel@vger.kernel.org, tmmlkml@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2006 18:05:20 +0200, Willy Tarreau wrote:
>> >>Oh there are tons of SATA bug fixes that 2.4.x is missing.  One of the 
>> >>biggest is the completely crappy exception handling.  If a SATA device 
>> >>is unplugged or spazzes out, the system may or may not recover.
>> >
>> >Already encountered on sata_nv in a sun x2100 :-)
>> >
>> >Jeff, I did not want to blindly merge patches from 2.6 to 2.4, but if
>> >you point me to a few ones you consider important, I'm willing to merge
>> >them.
>> 
>> As was hinted, it's not that easy, otherwise someone would have done it 
>> by now.  libata bug fixes require infrastructure that isn't present on 
>> 2.4.  The overall codebase is just too different to easily pull out 
>> select bug fixes.
>
>Of course for those. I was thinking about those which just change one
>register or things like this that I cannot identify the expected effect.
>If you agree, I'll enumerate the ones I've already noticed so that you
>just have to say yes/no/unknown on them. Don't worry, I don't want to
>spend lots of hours on this, since as I said, I do not receive any
>feedback from SATA users on 2.4 (neither positive nor negative).

Here's some positive feedback: My leafnode News server
(a 440BX chipset mobo with a Tualatin PIII-S) has been using
Promise SATA PCI cards (currently a SATA300 TX2plus) for its
disk storage since the SATA update patch was made available
for 2.4.29. It's been fast and reliable the entire time.

/Mikael
