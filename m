Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290243AbSAOS4h>; Tue, 15 Jan 2002 13:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290246AbSAOS41>; Tue, 15 Jan 2002 13:56:27 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:52695 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290243AbSAOS4M>; Tue, 15 Jan 2002 13:56:12 -0500
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local>
	<200201151653.g0FGrlG12428@vindaloo.ras.ucalgary.ca>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 15 Jan 2002 18:48:04 +0100
Message-ID: <87sn974iaz.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Richard Gooch <rgooch@ras.ucalgary.ca> writes:

> Olaf Dietsche writes:
> > To use this, you need to mount the file system and do a chown on the
> > appropriate ports:
> > 
> > # mount -t accessfs none /mnt
> > # chown www /mnt/net/ipv4/bind/80
> > # chown mail /mnt/net/ipv4/bind/25
> 
> Having to set the permissions like this on each boot seems a bit
> painful. Why not have permissions persistence like devfs has?

Well, for me it's a small script running at boot time. So, there's no
pain at all, unless planning or thinking in advance qualifies as pain ;-).

Seriously, this is a first cut. If there is real demand, I'll try to
come up with something. But I think, this will be a job for system
administrators or distribution builders. So, maybe a shell script with
fixed permissions will be sufficient. We will see.

First of all, I want to see, wether people like it at all or come up
alternative ideas.

Regards, Olaf.
