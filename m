Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280686AbRKBNXL>; Fri, 2 Nov 2001 08:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280687AbRKBNXB>; Fri, 2 Nov 2001 08:23:01 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:39304
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S280686AbRKBNWt>; Fri, 2 Nov 2001 08:22:49 -0500
Date: Fri, 02 Nov 2001 08:19:41 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, firetiger <firetiger977@163.com>
cc: linux-kernel@vger.kernel.org, "Vladimir V. Saveliev" <monstr@namesys.com>,
        Arjan van de Ven <arjanv@redhat.com>
Subject: Re: OOPS: reiserfs panic
Message-ID: <507960000.1004707181@tiny>
In-Reply-To: <3BE2958A.2070306@namesys.com>
In-Reply-To: <PIEMJKECONGJHFMFKFLHEEAGCAAA.firetiger977@163.com>
 <3BE2958A.2070306@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, November 02, 2001 03:46:02 PM +0300 Hans Reiser
<reiser@namesys.com> wrote:

> It is not a Linus kernel that RedHat gave you. Please try the latest
> Linus kernel, and tell us if that works. I think it will. Please give us
> info about exactly what kernel they shipped if you can.
> Hans
> 

Arjan, do any of the redhat kernels have the reiserfs brelse bug from
2.4.10-ac?  (missing a get_bh in
fs/reiserfs/inode.c:submit_bh_for_writepage)

-chris

