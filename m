Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319599AbSIMLBf>; Fri, 13 Sep 2002 07:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319601AbSIMLBf>; Fri, 13 Sep 2002 07:01:35 -0400
Received: from slider.rack66.net ([212.3.252.135]:26841 "EHLO
	slider.rack66.net") by vger.kernel.org with ESMTP
	id <S319599AbSIMLBe>; Fri, 13 Sep 2002 07:01:34 -0400
Date: Fri, 13 Sep 2002 13:07:10 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS?
Message-ID: <20020913110710.GB25353@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3D81B09B.7030405@iinet.net.au> <Pine.LNX.4.44.0209131250480.8722-100000@magic.vamo.orbitel.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209131250480.8722-100000@magic.vamo.orbitel.bg>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 01:22:22PM +0300, Ivan Ivanov wrote:
> 
> I think that it is not fair to insist for merging of XFS only. There ara
> many other projects that are of bigger value for linux then iet another
> filesystem - RSBAC,OpenMosix,LSM,HTree and more.

And who are most likely far more intrusive than XFS is currently, or have
other issues. [1]

> Some people like Linus, Alan, Marchelo etc. have the responsibility to
> provide users with a usable, stable kernel.

So they mark XFS experimental, and unless the user configures for
experimental features to be asked for they won't even notice their presence.

> I am not an expert, just a sysadmin, and I am testing XFS since kernel
> 2.4.6 ( I am writing this mail from a test machine with kernel 2.4.18
> and XFS root filesystem ), and I also think that XFS is not ready for
> production ( I lost some unimportant files after a crash yesterday ).

So, you are not using ext2 then either? Since that can loose files, too, on
a crash. (I've actually even once seen a whole ext2 partition disappear
after a crash. Same for reiserfs, BTW)

Any fs can have bugs. Even while ext2 is indeed more likely to be the most
tested, it too can bite you sometimes. [1]


Regards,

Filip

[1] Actually I've had problems with dma timeouts resulting in ide hangs on
    an ext2 system last week, and it too managed to lose a few files. Sure,
    fsck picked up most of them, and none were critical, but it does prove
    my point well enough.

-- 
We have joy, we have fun,
we have Linux on our Sun.
	-- Andreas Tille
