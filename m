Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbSJBVHy>; Wed, 2 Oct 2002 17:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262601AbSJBVHy>; Wed, 2 Oct 2002 17:07:54 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:63984 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262600AbSJBVHv>; Wed, 2 Oct 2002 17:07:51 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021002210609.575031EA74@alan.localdomain> 
References: <20021002210609.575031EA74@alan.localdomain>  <20021002103932.C35A21EA74@alan.localdomain> <4631.1033558083@passion.cambridge.redhat.com> 
To: Alessandro Amici <alexamici@tiscali.it>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Re: 2.5.37+ i386 arch split broke external module builds 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Oct 2002 22:13:19 +0100
Message-ID: <20770.1033593199@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alexamici@tiscali.it said:
>  average users may have either a kernel-headers package that matches
> their  running kernel and/or a souce package without the configuration
> stuff. in  both cases 'the hacker way' doesn't work :)

Often nowadays they'll not have 'kernel-headers' but instead 
'glibc-kernheaders' which is littered with '#ifdef __KERNEL__ #error' to 
prevent people from doing that.

If you don't have the corresponding source and configuration, you cannot
build a module with any reasonable chance of success -- at least for my
definition of 'reasonable' in the context of shipping drivers to the Great
Unwashed.

> OTOH, for small device drivers you don't need the full blown kernel
> CFLAGS,  you know what you need anyway. 

Build for Alpha and tell me that again :)

--
dwmw2


