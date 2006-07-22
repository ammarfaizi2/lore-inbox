Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWGVU3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWGVU3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 16:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWGVU3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 16:29:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:27782 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751031AbWGVU3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 16:29:12 -0400
Message-ID: <44C28A8F.1050408@garzik.org>
Date: Sat, 22 Jul 2006 16:29:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C26F65.4000103@namesys.com>
In-Reply-To: <44C26F65.4000103@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Theodore Tso wrote:
> 
>> Actually, the first bits
>>
> yes, the first bits....   other people send in completed filesystems....

Completed filesystems have a much higher barrier to entry, because they 
require a fresh review.

ext4 will go upstream MUCH faster, because it follows the standard 
process of Linux evolution, building on top of existing code with 
progressive changes:

	cp -a ext3 ext4
	update ext4
	update ext4
	update ext4
	...

This process builds upon existing reviews and knowledge of existing 
code.  This process also guarantees a higher degree of stability during 
development, because the interim changes must always form a complete, 
working, usable filesystem.


> As the other poster mentioned, they went off to startups, and did not
> become part of our community.  How much of that was because their
> contributions were more hassled than welcomed, I cannot say with
> certainty, I can only say that they were discouraged by the difficulty
> of getting their stuff in, and this was not as it should have been. 
> They were more knowledgeable than we were on the topics they spoke on,
> and this was not recognized and acknowledged.
> 
> Outsiders are not respected by the kernel community.  This means we miss
> a lot.

Anyone who fails to respect the kernel development process, the process 
of building consensus, is turn not respected, flamed, and/or ignored.

If you don't respect us, why should we respect you?


> No, because distros would wait until it is not experimental before
> giving it to their users by default, in my proposed release model.  lkml

Distros follow their own release model, and don't have a care about what 
Hans Reiser thinks they should do.

<vendor hat on>
Red Hat has a pipeline in place for offering new technologies to users: 
  Fedora Core -> RHEL, and sometimes RHEL technology previews.  SuSE 
presumably does something similar with OpenSUSE.
</vendor hat>

There is PLENTY of opportunity to be experimental.


> is populated with people FAR more suited to experimenting with
> experimental filesystems than typical distro customer lists are.  It is
> commercial and political reasons that motivate distros being the first
> with patches not tried yet by lkml, not the interests of the users.

> Now, for other patches these commercial and political reasons may need
> to be catered to as the price of getting the Redhats of the world to
> fund kernel development, but that logic does not apply to Reiser4's
> particulars.

I always feel sad to hear technologists wail about politics.

In my experience, the cause of such is almost always the fault of the 
submittor, ignoring consensus.  But once the submittor has decided that 
"politics" are cause of their troubles, the submittor focuses on that 
rather than addressing the technology objections that were raised.

With you in particular, you demonstrated NO interest in maintaining 
reiser3, once reiser4 began to make a splash.  Linux kernel code exists 
for DECADES, and as such, long term maintenance is a CRITICAL aspect of 
development.

Regardless of whatever new whiz-bang technology exists in reiser4, there 
is a very real worry that you will abandon reiser4 once its in the tree 
for a few years, just like what happened with reiser3.

	Jeff


