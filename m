Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVANMWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVANMWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 07:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVANMWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 07:22:43 -0500
Received: from lakermmtao04.cox.net ([68.230.240.35]:17833 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261966AbVANMWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 07:22:41 -0500
In-Reply-To: <20050114120101.GA29859@pazke>
References: <71216E5F-5F6C-11D9-B39F-000393ACC76E@mac.com> <20050114120101.GA29859@pazke>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FBD27F98-6626-11D9-A56D-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Russell King <rmk+serial@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] [2.6] Clean up useless 8250 siig functions and header
Date: Fri, 14 Jan 2005 07:22:40 -0500
To: Andrey Panin <pazke@donpac.ru>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 14, 2005, at 07:01, Andrey Panin wrote:
> On 005, 01 05, 2005 at 05:52:14PM -0500, Kyle Moffett wrote:
>> This removes two simple siig functions that should just be integrated
>> into the calling code.
>
> Good idea, wrong patch. You deleted wrapper code, but actual init
> functions left not exported for use by parport_serial module.
> Even worse, they are left static, so monilithic kernel build will
> not work too :/

Oops, sorry!

> Did you compiled the kernel with your patch applied ?

Yes, but I think I managed to lose some changes somewhere in the
process of managing my patchset.

> Please use attached patch instead.

Thanks,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


