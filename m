Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWGRXGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWGRXGJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 19:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGRXGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 19:06:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:22360 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932410AbWGRXGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 19:06:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GudBxVnlZZpxH+/s7BTSOEI7ppha2/DA8KkLHeDAzyaMaPA89G5JYLufmzi5aCIcjPdWil91X4PMLDoHKLPqMReyZxwTnQl/pqwVcHJqux6w933ryofiYP+mCqv+beJZ21y9dI6MlrUPPua4qQ6q2G5kTZaSoVzVmjvIi5Xh+/s=
Message-ID: <3b0ffc1f0607181606x1e6b1744j52a77a68cbaf2917@mail.gmail.com>
Date: Tue, 18 Jul 2006 19:06:06 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Torsten Landschoff" <torsten@debian.org>
Subject: Re: XFS breakage in 2.6.18-rc1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060718222941.GA3801@stargate.galaxy>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060718222941.GA3801@stargate.galaxy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/06, Torsten Landschoff <torsten@debian.org> wrote:
> Hi friends,
>
> I upgraded to 2.6.18-rc1 on sunday, with the following results (taken
> from my /var/log/kern.log), which ultimately led me to reinstall my
> system:
[snip]
> That problem occured during a dist-upgrade, dm-6 is my /usr partition. Funny
> enough this happened a few months after finally replaced my ancient disk
> with a RAID1 array to make sure I do not lose data ;)
>
>
> In any case it seems like the XFS driver in 2.6.18-rc1 is decently broken.
> After booting into 2.6.17 again, I could use /usr again but random files
> contain null bytes, firefox segfaults instead of starting up and a number
> of programs fail in mysterious ways. I tried to recover using xfs_repair
> but I feel that my partition is thorougly borked. Of course no data was
> lost due to backups but still I'd like this bug to be fixed ;-)
>
> If more information from my logs is required, I can make it available (and any
> part of the partition if required).

That looks like the death knell of my /, which succumbed on Friday as
a result (I believe) of the corruption bug that was in 2.6.16/17.
Ironically enough, I also saw the problem during an aptitude upgrade.

Also see this thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115070320401919&w=2

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
