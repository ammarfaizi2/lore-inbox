Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRCWCGy>; Thu, 22 Mar 2001 21:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRCWCGp>; Thu, 22 Mar 2001 21:06:45 -0500
Received: from zrtps06s.nortelnetworks.com ([47.140.48.50]:13284 "EHLO
	zrtps06s.us.nortel.com") by vger.kernel.org with ESMTP
	id <S129321AbRCWCG3>; Thu, 22 Mar 2001 21:06:29 -0500
Message-ID: <3ABAABF9.294E89BD@asiapacificm01.nt.com>
Date: Fri, 23 Mar 2001 01:50:49 +0000
From: "Andrew Morton" <morton@nortelnetworks.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.2-ac19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Frank de Lange <frank@unternet.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2-ac21
In-Reply-To: <4514.985311303@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <morton@asiapacificm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> Am I the only person who is annoyed that nmi watchdog is now off by
> default and the only way to activate it is by a boot parameter?  You
> cannot even patch the kernel to build a version that has nmi watchdog
> on because the startup code runs out of the __setup routine, no boot
> parameter, no watchdog.

It was causing SMP boxes to crash mysteriously after
several hours or days.  Quite a lot of them.  Nobody
was able to explain why, so it was turned off.
