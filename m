Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWGXS3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWGXS3P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWGXS3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:29:15 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:44988 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751378AbWGXS3N (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:29:13 -0400
Message-ID: <44C5116D.2070901@garzik.org>
Date: Mon, 24 Jul 2006 14:29:01 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>, Theodore Tso <tytso@mit.edu>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Nikita Danilov <nikita@clusterfs.com>, Steve Lord <lord@xfs.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C42B92.40507@xfs.org> <17604.31844.765717.375423@gargle.gargle.HOWL> <20060724103023.GA7615@thunk.org> <20060724113534.GA64920@dspnet.fr.eu.org> <20060724133939.GA11353@thunk.org> <20060724153853.GA88678@dspnet.fr.eu.org> <20060724161755.GA3317@thunk.org> <20060724175055.GA97168@dspnet.fr.eu.org>
In-Reply-To: <20060724175055.GA97168@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> The fact that the ext maintainers are very, very good helps quite a
> lot too.  But I think it doesn't change the fact that if r4 has been a
> set of patches through time to r3, good or not, there wouldn't be a
> discussion.

That's a huuuuuge leap of logic.

Metadata plugins found in reiser4 are far better done at the VFS level, 
than burying "reiser4 can look like ext2, if it wishes" functionality 
inside the filesystem.

I guarantee such a patch to reiser3 would get rejected.


> It's maybe the lack of an official development branch, but it looks
> like the kernel development has become very risk-averse, and the bar
> is set much higher to accept anything that looks relatively new.  Any
> reason is good to have it dropped, cosmetic or not.

New stuff goes in all the time.

The bar is set too high in some cases (read: SCSI subsystem 
submissions), but reiser4 submission cannot be generalized as you have 
done here.  There are very real issues present, that need to be dealt with.


> Just to give you an idea, if the criteria applied to suspend2 or
> reiser4 had been applied to everything else, we wouldn't have at least
> XFS[1], ALSA[2], sysfs[3] and DRM[4].  Whether it is good or bad is an
> interesting question itself.  But before, code just had to be
> reasonably sane, and it was expected to be fixed through time.  Some
> even has been (sysfs got better).  Now it has to attain an ever moving
> level of perfection before it has a chanc to be accepted.

reiser4 tries to be another VFS.  That's a bit more than needing 
additional minor fixes over time.

	Jeff


