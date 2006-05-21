Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWEUSlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWEUSlY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 14:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWEUSlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 14:41:24 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:43917 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964898AbWEUSlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 14:41:24 -0400
Date: Sun, 21 May 2006 20:40:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: linux-kernel@vger.kernel.org, apiszcz@lucidpixels.com
Subject: Re: Linux Kernel Source Compression
In-Reply-To: <Pine.LNX.4.64.0605211028100.4037@p34>
Message-ID: <Pine.LNX.4.61.0605212026570.6083@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0605211028100.4037@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Was curious as to which utilities would offer the best compression ratio for
> the kernel source, I thought it'd be bzip2 or rar but lzma wins, roughly 6 MiB
> smaller than bzip2.
>
You forgot:
  - .7z    7zip
  - .j     JAR (www.arjsoftware.com)
  - .ice   LHICE (some sort of "brother" to lharc aka lzh)
  - .ace   ACE (www.winace.com)
  -        UPX (yes!, you just need to put '#!/\n' at the front)
  - .cab   MS CAB (use winace)
  - .bh    BlackHole
  - .pak   PKARC 2.51
  - .sqz   SqueezeIt
  - "LZEXE"

ftp://camelot.spsl.nsc.ru/pub/win32/arc/ - you'll find some there
happy packing :)

> 38064   linux-2.6.16.17.tar.rz

  - is this rzip with _maximum_ distance?


Jan Engelhardt
-- 
