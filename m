Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVCYEbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVCYEbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 23:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVCYEbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 23:31:51 -0500
Received: from smtpout.mac.com ([17.250.248.44]:16636 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261221AbVCYEbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 23:31:37 -0500
In-Reply-To: <a44ae5cd050324201565814701@mail.gmail.com>
References: <a44ae5cd050324201565814701@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <28bdcf7251e360b81370397cc74a197f@mac.com>
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Error building ndiswrapper-1.0rc1 against 2.6.12-rc1-mm2 sources
Date: Thu, 24 Mar 2005 23:31:27 -0500
To: Miles Lane <miles.lane@gmail.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2005, at 23:15, Miles Lane wrote:
> Hi,
>
> Was this change intentional or accidental?  I have successfully built
> ndiswrapper-1.0rc1 with the other recent kernel trees.
>
> warning: passing arg 4 of `call_usermodehelper' makes pointer from 
> integer without a cast
> error: too few arguments to function `call_usermodehelper'

call_usermodehelper was extended with a parameters to allow a
keyring environment to be passed.  As this is -mm, who knows
whether the patch will make it into mainline or not.  I suspect
it will, though, due to its utility at which point external
modules will need to be converted.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


