Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266174AbUHJNXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUHJNXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUHJNUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:20:36 -0400
Received: from lakermmtao09.cox.net ([68.230.240.30]:766 "EHLO
	lakermmtao09.cox.net") by vger.kernel.org with ESMTP
	id S264808AbUHJNSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:18:52 -0400
In-Reply-To: <200408101246.i7ACkTbm014030@burner.fokus.fraunhofer.de>
References: <200408101246.i7ACkTbm014030@burner.fokus.fraunhofer.de>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D20572A9-EACF-11D8-BC30-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: lkml List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Tue, 10 Aug 2004 09:18:51 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 10, 2004, at 08:46, Joerg Schilling wrote:
> Your statements are correct for programs that include locale support.

Programs that do not support locales _must_ restrict themselves to
7-bit ASCII, or they are likely to break any number of things by 
outputting
invalid characters to the terminal.  You could quite easily replace the 
(C)
symbol with the string "Copyright", or you could pick a more complicated
solution by actually implementing locales, but you should change the
behavior of cdrecord, as that is broken/buggy.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


