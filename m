Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288057AbSAMT6O>; Sun, 13 Jan 2002 14:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288058AbSAMT6F>; Sun, 13 Jan 2002 14:58:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32321 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S288057AbSAMT5w>; Sun, 13 Jan 2002 14:57:52 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <Pine.GSO.4.21.0201122045540.24774-100000@weyl.math.psu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jan 2002 12:55:06 -0700
In-Reply-To: <Pine.GSO.4.21.0201122045540.24774-100000@weyl.math.psu.edu>
Message-ID: <m1k7umqb51.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On Sat, 12 Jan 2002, H. Peter Anvin wrote:

> > c_chksum      8 bytes		 CRC of data field if c_magic is 070702
> 
> +				or "00000000" if it's 070701.  Kernel
> +				is not expected to verify it in any case.

Why is the kernel not expected to check the data integrity?  Usually
end to end data integrity is important.  And a check on the data integrity
and tells us that either the bootloader or the hardware is messed up
can save hours of debugging?

Eric
