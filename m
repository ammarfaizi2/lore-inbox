Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265537AbRGCRXM>; Tue, 3 Jul 2001 13:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265534AbRGCRWx>; Tue, 3 Jul 2001 13:22:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:36281 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265436AbRGCRWr>;
	Tue, 3 Jul 2001 13:22:47 -0400
Date: Tue, 3 Jul 2001 13:22:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Admin Mailing Lists <mlist@intergrafix.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: ufs on linux question/problem
In-Reply-To: <Pine.LNX.4.10.10107031309240.20297-100000@athena.intergrafix.net>
Message-ID: <Pine.GSO.4.21.0107031321200.11619-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Jul 2001, Admin Mailing Lists wrote:

> 
> Trying to mount a solaris x86 drive under linux.
> kernel 2.4.5, ufs support and x86 partition support compiled in (no
> module)
> On boot, linux recognizes the drive, but shows no solaris partitions on
> it.
> Below, linux drive is hda, solaris is hdb.

You need support of Solaris disklabels. And UFS patches that are in
-ac. Then you can get more or less safe r/o mounts. r/w is hopeless
at that stage.

