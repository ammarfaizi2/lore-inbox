Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVCAEZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVCAEZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 23:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVCAEZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 23:25:53 -0500
Received: from smtpout.mac.com ([17.250.248.87]:22991 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261236AbVCAEZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 23:25:38 -0500
In-Reply-To: <Xine.LNX.4.44.0502282311190.26032-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0502282311190.26032-100000@thoron.boston.redhat.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F00DE41E-8A09-11D9-858B-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: lkml Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, sds@epoch.ncsc.mil,
       Alexander Nyberg <alexn@dsv.su.se>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] SELinux: null dereference in error path
Date: Mon, 28 Feb 2005 23:25:27 -0500
To: James Morris <jmorris@redhat.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 28, 2005, at 23:11, James Morris wrote:
> On Tue, 1 Mar 2005, Alexander Nyberg wrote:
>
>> The 'bad' label will call function that unconditionally dereferences
>> the NULL pointer.
>>
>> Found by the Coverity tool
>>
>> Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>
>
> Signed-off-by: James Morris <jmorris@redhat.com>

Err, isn't it "Acked-by:"??  I thought "Signed-off-by:" was only for 
when
the patch actually went through someone's tree and was forwarded by them
to somebody else:

EG:
John Doe writes a patch that fixes a NULL pointer deref, and he sends it
to Andrew Morton.  The maintainer of the driver, Jane McDonald, confirms
the fix via email to this list.  Andrew forwards it to Linus, who
includes it in his next release.  The resulting notations look like 
this:

Signed-off-by: John Doe
Acked-by: Jane McDonald
Signed-off-by: Andrew Morton
Signed-off-by: Linus Torvalds

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


