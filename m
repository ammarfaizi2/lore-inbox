Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131269AbRCNJmg>; Wed, 14 Mar 2001 04:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131293AbRCNJm0>; Wed, 14 Mar 2001 04:42:26 -0500
Received: from nas21-103.wms.club-internet.fr ([213.44.50.103]:8182 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S131269AbRCNJmT>;
	Wed, 14 Mar 2001 04:42:19 -0500
Message-Id: <200103140938.KAA12099@microsoft.com>
Subject: Re: ln -l says symlink has size 281474976710666
From: Xavier Bestel <xavier.bestel@free.fr>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: John R Lenton <john@grulic.org.ar>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore \"Y.\" Ts'o" <tytso@mit.edu>
In-Reply-To: <200103140558.f2E5w8P06685@webber.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution (0.9/+cvs.2001.03.06.23.22 - Preview Release)
Date: 14 Mar 2001 10:38:59 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13 Mar 2001 22:58:08 -0700, Andreas Dilger a écrit :
> Luckily, after the symlink is created it ignores the size, and only uses
> the i_blocks count to determine if the symlink is stored in the inode
> itself or in another block (the fast symlink will be NUL terminated).
> It could well have been corruption from a long time ago, and only with
> 2.4.x and LFS you have noticed it.

BTW, if I hand-make an ext2 fs with tiny files stored directly in the
inode, will it work ? Silly question ?

Xav

