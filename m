Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262912AbSJaQ2j>; Thu, 31 Oct 2002 11:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSJaQ2j>; Thu, 31 Oct 2002 11:28:39 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:9907 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262912AbSJaQ2h>; Thu, 31 Oct 2002 11:28:37 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 31 Oct 2002 18:03:40 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.45: initrd broken?
Message-ID: <20021031170340.GA18058@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

2.5.45 doesn't boot for me.  I'm using a initrd to load some modules.
The last lines I see are:

  (1) RAMDISK telling me it has found a image.
  (2) initrd is freed
  (3) Oops.

2.5.44 used to print it has mounted the root fs (i.e. the initrd)
instead of oopsing.

I can hook up a serial console to grab the exact messages if needed.

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
