Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277552AbRJRBOQ>; Wed, 17 Oct 2001 21:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277531AbRJRBOG>; Wed, 17 Oct 2001 21:14:06 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:47283 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S277552AbRJRBN6>;
	Wed, 17 Oct 2001 21:13:58 -0400
Message-ID: <3BCE2C2D.D588ACF3@sun.com>
Date: Wed, 17 Oct 2001 18:11:09 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
CC: groudier@club-internet.fr, alan@redhat.com, torvalds@transmeta.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] resubmitting sym53c8xx patches
In-Reply-To: <20011017201539.E1402-100000@gerard>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:

> About your proposal, it has not been NOKed, but it is not the way I would
> have implemented it. By the way, I already have cleaned up the module
> timer killing ins sym-2.1.15 driver (easily back-portable to sym53c8xx).
> You may look at it (ftp.tux.org) if you are interested in knowing how I

I will look at it.

> The reboot handler stuff is useless in my opinion and OTOH last time I
> looked in the kernel code related to reboot handler stuff it looks to me
> very incomplete. Useless stuff implies additionnal bugs that could have
> been avoided.

We have a bootloader that loads a kernel, then loads another kernel. 
Without the reboot handler, we get weird behavior, and SCSI that does not
initialize properly for the second kernel.  It may not be useful to
everyone, but it is essential to some.

> I am not opposed to your patch and will not complain if it is applied to
> kernel 2.4. I just haven't time for submitting another patch quickly nor
> have time for following any breakage due to its new interactions with the
> kernel.

I appreciate your concern on this.   I'll re-examine the timer stuff, and
if possible, I'd like to get to agreement ASAP, so we can X it off our list
of changes.

Thanks

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
