Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319195AbSHNEBz>; Wed, 14 Aug 2002 00:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319196AbSHNEBz>; Wed, 14 Aug 2002 00:01:55 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:56824 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319195AbSHNEBy>; Wed, 14 Aug 2002 00:01:54 -0400
Date: Wed, 14 Aug 2002 00:05:46 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
Message-ID: <20020814000546.B15947@redhat.com>
References: <3D59CBFA.9CFC9FEE@zip.com.au> <20020813235803.A15947@redhat.com> <3D59D5E6.1010608@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D59D5E6.1010608@zytor.com>; from hpa@zytor.com on Tue, Aug 13, 2002 at 09:00:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 09:00:38PM -0700, H. Peter Anvin wrote:
> First of all, only CAP_SYS_ADMIN.  As far as spamming the ring buffer, 
> that's trivial to do today by just sending a bunch of bad network 
> packets,

Not true, network logging is rate limited.

> or attaching a USB CD-ROM without a disc in the drive (yes, 
> really... on my wife's laptop it was so bad that unless she unplugged 
> the CD-ROM syslogd was eating her system alive), or...

Well, that's more of a bug and requires console access anyways.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
