Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292532AbSBTV4i>; Wed, 20 Feb 2002 16:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292528AbSBTV42>; Wed, 20 Feb 2002 16:56:28 -0500
Received: from tomts21.bellnexxia.net ([209.226.175.183]:5624 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S292526AbSBTV4O>; Wed, 20 Feb 2002 16:56:14 -0500
Date: Wed, 20 Feb 2002 16:55:48 -0800
From: Jason Yan <jasonyanjk@yahoo.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Is there any story about the magic number 0x08048000 in  "ld" internal linker script ?
X-mailer: FoxMail 4.0 beta 2 [cn]
Message-Id: <20020220215605.KXU6407.tomts21-srv.bellnexxia.net@abc337>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I use gdb to trace/debug my program, I notice that the programe linear address always start from 0x8048xxx, then I use "ld --verbose" to display the internal linker script, I find an interesting address 0x08048000 :

SECTIONS
{
  /* Read-only sections, merged into text segment: */
  . = 0x08048000 + SIZEOF_HEADERS
  ......snip....

that's where 0x8048xxx comes from. I'm just curious, why 0x08048000 not other number? Any story?

Thanks,

Jason 




