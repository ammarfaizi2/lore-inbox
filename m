Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268004AbTAKTWe>; Sat, 11 Jan 2003 14:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268007AbTAKTWe>; Sat, 11 Jan 2003 14:22:34 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:26098 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S268004AbTAKTWc>; Sat, 11 Jan 2003 14:22:32 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200301111634.h0BGYGUt003680@eeyore.valparaiso.cl> 
References: <200301111634.h0BGYGUt003680@eeyore.valparaiso.cl> 
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: UnitedLinux violating GPL? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 Jan 2003 19:27:59 +0000
Message-ID: <10213.1042313279@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


brand@jupiter.cs.uni-dortmund.de said:
>  Great! The "complete source code" for the kernel does include each
> and every single patch applied since linux-0.0.1? Guess I'll have to
> complain to a certain Torvalds then...

> Don't be silly. "Complete source code" means the source needed to
> rebuild the binary, nothing more. If that is a mangled version derived
> from some other  source, so be it. You are explicitly allowed to
> distribute changed versions, but only under GPL. [IANAL etc, so...]

I disagree. A preprocessed source file with all the variables renamed to 
random strings would suffice to rebuild the binary, and is obviously not 
acceptable -- being able to rebuild the binary is not the only criterion.

	"The source code for a work means the preferred form of the work
	for making modifications to it."

Note that the GPL doesn't say you have to give it in the preferred form for 
_building_ it, but the preferred form for _modifying_ it. 

In the opinion of many devlopers, the preferred form of the Linux kernel for
maintaining it is a set of individual patches against the closest
'official' release, and not a tarball containing already-modified code. 

--
dwmw2


