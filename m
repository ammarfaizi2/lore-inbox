Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSJPMK2>; Wed, 16 Oct 2002 08:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSJPMK2>; Wed, 16 Oct 2002 08:10:28 -0400
Received: from [198.149.18.6] ([198.149.18.6]:46060 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262425AbSJPMK0>;
	Wed, 16 Oct 2002 08:10:26 -0400
Subject: Re: XFS build error on m68k in 2.5.43
From: Stephen Lord <lord@sgi.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Nikita@namesys.com, geert@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
In-Reply-To: <20021016.050031.31945417.davem@redhat.com>
References: <Pine.GSO.4.21.0210161319210.9988-100000@vervain.sonytel.be>
	<15789.19959.929002.906160@laputa.namesys.com> 
	<20021016.050031.31945417.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Oct 2002 07:11:58 -0500
Message-Id: <1034770320.1078.26.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 07:00, David S. Miller wrote:
>    From: Nikita Danilov <Nikita@Namesys.COM>
>    Date: Wed, 16 Oct 2002 15:31:03 +0400
>    
>    Second parameter of xfs_bmbt_disk_set_allf is 0 (zero). Try to replace
>    it with O.
> 
> You'll need lots more fixes ever after that, big-endian
> is pretty broke with the most recent updates.
> 
> Here are the fixes I sent to the XFS maintainers.
> 

Thanks Dave, this all looks good, have to see if we a big endian
box around here somewhere in future.

Steve
 

