Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbSJUPuq>; Mon, 21 Oct 2002 11:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSJUPuq>; Mon, 21 Oct 2002 11:50:46 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:51380 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261415AbSJUPup>; Mon, 21 Oct 2002 11:50:45 -0400
Subject: Re: [PATCH] shmem missing cache flush
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: rmk@arm.linux.org.uk, hugh@veritas.com, willy@debian.org, akpm@zip.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021021.082107.56539790.davem@redhat.com>
References: <20021017011957.A9589@flint.arm.linux.org.uk>
	<20021016.171626.112600105.davem@redhat.com>
	<1035212657.27259.154.camel@irongate.swansea.linux.org.uk> 
	<20021021.082107.56539790.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 17:12:22 +0100
Message-Id: <1035216742.27318.189.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 16:21, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 21 Oct 2002 16:04:17 +0100
>    
>    I disagree here. Its a measurable performance item, and its actually
>    going to break less code than for example the last minute scsi and bio
>    changes have done
>    
> That's a good point.
> 
> So, if you want to merge the deprecation to Linus when he returns
> I'd fully support it :-)

Fine by me. The m68k people can thank me for all the 5380 fixing I've
been doing instead. Send me the diffs Im happy to give them a spin.
Compared to a bit of vm work the rest of the stuff needed is way way
worse. I'd hate to be fixing the atari st ide support in 2.5 8) although
I do want to see suspend to disk on an amiga


Alan

