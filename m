Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSBSNe0>; Tue, 19 Feb 2002 08:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291402AbSBSNeQ>; Tue, 19 Feb 2002 08:34:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:24474 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291401AbSBSNeF>;
	Tue, 19 Feb 2002 08:34:05 -0500
Date: Tue, 19 Feb 2002 08:34:03 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jos Hulzink <josh@stack.nl>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: VFS issues (was: Re: 2.5.5-pre1: mounting NTFS partitions -t
 VFAT)
In-Reply-To: <20020219102539.J93925-100000@snail.stack.nl>
Message-ID: <Pine.GSO.4.21.0202190833030.8070-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Feb 2002, Jos Hulzink wrote:

> While mounting a partition, the vfs layer tries to determine the partition

It doesn't and it shouldn't.  mount(8) does, so there's no reason to do that
in kerenl.

