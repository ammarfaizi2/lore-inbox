Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265940AbRFZIKK>; Tue, 26 Jun 2001 04:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265941AbRFZIJv>; Tue, 26 Jun 2001 04:09:51 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:60679 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S265940AbRFZIJm>; Tue, 26 Jun 2001 04:09:42 -0400
Date: Tue, 26 Jun 2001 11:09:33 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: ext3-users@redhat.com, linux-kernel@vger.kernel.org,
        Florian Lohoff <flo@rfc822.org>
Subject: Re: Oops in iput
Message-ID: <20010626110933.R1503@niksula.cs.hut.fi>
In-Reply-To: <20010625201612.A701@paradigm.rfc822.org> <20010625194213.J18856@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010625194213.J18856@redhat.com>; from sct@redhat.com on Mon, Jun 25, 2001 at 07:42:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2001 at 07:42:13PM +0100, you [Stephen C. Tweedie] claimed:
> Hi,
> 
> On Mon, Jun 25, 2001 at 08:16:12PM +0200, Florian Lohoff wrote:
> > 
> > oops in iput - Kernel 2.2.19/i386 + ide-udma patches + ext3 patches (0.0.7a)
> 
> The ide-udma patches for 2.2 haven't had nearly the testing of the 2.4
> ones, and simply can't be trusted as a baseline for debugging other
> code.  Can you reproduce this problem without them applied?  The oops
> here is a networking oops on the face of it, and I wouldn't expect to
> see that on 2.2 unless something was corrupting memory.

Well, I for one use the 2.2 ide patches extensively (on almost all of my
machines, including a heavy-duty backup server), and haven't seen any
problems whatsoever. I see _much_ more problems with scsi (aic7xxx), for
example.

I don't mean to say the ide patches are 100% bug free, but I wouldn't
consider them as the prime suspect for an oops that happened elsewhere
either. It could be hw or any other part of kernel just as well... What
about memtest86?


-- v --

v@iki.fi
