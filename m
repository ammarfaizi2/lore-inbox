Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVADCYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVADCYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 21:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVADCYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 21:24:10 -0500
Received: from lakermmtao01.cox.net ([68.230.240.38]:7099 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261967AbVADCXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 21:23:50 -0500
In-Reply-To: <16857.63978.65838.823252@samba.org>
References: <41D9C635.1090703@zytor.com> <16857.56805.501880.446082@samba.org> <41D9E3AA.5050903@zytor.com> <16857.59946.683684.231658@samba.org> <41D9EDF6.1060600@zytor.com> <16857.62250.259275.305392@samba.org> <41D9F65E.3030301@zytor.com> <16857.63978.65838.823252@samba.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <AA7F1C76-5DF7-11D9-B689-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: aia21@cantab.net, samba-technical@lists.samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ntfs-dev@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       sfrench@samba.org, "H. Peter Anvin" <hpa@zytor.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
Date: Mon, 3 Jan 2005 21:23:48 -0500
To: tridge@samba.org
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 03, 2005, at 21:05, tridge@samba.org wrote:
> Once the Samba LSM module is done and Wine and Samba start working
> more together on all these extra bits of meta-data then we could
> consider making your ioctl work on all filesystems when the LSM module
> is loaded.

IMHO, it would be really nice (Although I realize this would be a 
humongous
task) if there was a "Linux" ACL system supported by the VFS that is 
backwards
compatible with UNIX perms, POSIX ACLs, and NTFS ACLs (One of the few
things that Microsoft got right).  The fact stands that NT ACLs are 
much more
powerful and useful than their POSIX counterparts (Although some of the
subdirectory inheritance stuff is rather uselessly algorithmically 
complicated.)

I think it would be a major achievement if some kind of design and API 
could
be decided upon, because at least that way there would be some kind of
foundation upon which to build patches.

I'd like to work on a patch for this, but I'm afraid my kernel coding 
skills are a
bit rusty at the moment. Sorry :-D

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------

