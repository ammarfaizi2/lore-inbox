Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266360AbRGBDei>; Sun, 1 Jul 2001 23:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbRGBDe2>; Sun, 1 Jul 2001 23:34:28 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:21228 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266360AbRGBDeR>; Sun, 1 Jul 2001 23:34:17 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 1 Jul 2001 20:34:07 -0700
Message-Id: <200107020334.UAA02295@adam.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Cc: linux-kernel@vger.kernel.org, rhw@MemAlpha.CX, rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:
>On Sun, 1 Jul 2001 19:25:11 -0700, 
>"Adam J. Richter" <adam@yggdrasil.com> wrote:
>>	Does anyone know if there is any code that would break if
>>we put quotation marks around the $CONFIG_xxxx references in the
>>dep_xxx commands in all of the Config.in files?

>That has the same problem that AC was worried about.  Variables that
>used to be treated as "undefined, don't care" are now treated as
>"undefined, assume n and forbid".

	What variables?  Please show me a real example.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
