Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262744AbSJCFor>; Thu, 3 Oct 2002 01:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262745AbSJCFor>; Thu, 3 Oct 2002 01:44:47 -0400
Received: from [203.117.131.12] ([203.117.131.12]:19406 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262744AbSJCFoo>; Thu, 3 Oct 2002 01:44:44 -0400
Message-ID: <3D9BDA8D.5080700@metaparadigm.com>
Date: Thu, 03 Oct 2002 13:50:05 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Marowsky-Bree <lmb@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
References: <Pine.GSO.4.21.0210021922200.13480-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/02 07:22, Alexander Viro wrote:
> 
> On Wed, 2 Oct 2002, Andreas Dilger wrote:
> 
> 
>>On Oct 02, 2002  23:46 +0100, Alan Cox wrote:
>>
>>>Absolutely - taking the core EVMS(say the core code and the bits to do
>>>LVM1) and polishing them up to be good clean citizens without code
>>>duplication and other weirdness would be a superb start for EVMS as a
>>>merge candidate. The rest can follow a piece at a time once the core is
>>>right if EVMS is the right path
>>
>>I actually see EVMS as the "VFS for disk devices".  It is a very good
>>way to at allow dynamic disk device allocation, and could relatively
>>easily be modified to use all of the "legacy" disk major devices and
>>export only real partitions (one per minor).
>>
>>You could have thousands of disks and partitions without the current
>>limitations on major/minor device mapping.
>>
>>This was one of the things that Linus was pushing for when 2.5 started.
> 
> 
> ... and you don't need EVMS for that.

But EVMS would be an excellent substitute in the mean time.

Better to having something excellent now than something perfect but
too late.

The EVMS guys have done a great job of cleanly integrating with 2.5,
the single additional interface they needed to add to genhd.c is
testament to their consideration of these issues.

IBM seem to have done a great job creating the most extensive and
complete logical volume manager for Linux (including a suite of end
user tools much more extensive than LVM). They have also shown the
commitment to keep it current and cleary are way further ahead than
any other contender. It would be horrible if not getting the nod from
the right friends deprived users of a *complete* logical volume manager
in 2.5 anytime soon.

Peace, love and Linux ;)

~mc

