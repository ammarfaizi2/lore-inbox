Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275178AbRJGNnc>; Sun, 7 Oct 2001 09:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276359AbRJGNnW>; Sun, 7 Oct 2001 09:43:22 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:58294 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S275178AbRJGNnI>;
	Sun, 7 Oct 2001 09:43:08 -0400
Date: Sun, 7 Oct 2001 15:43:24 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org
Subject: zisofs doesn't compile in 2.4.10-ac7
Message-ID: <20011007154324.A4991@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux version 2.4.8-ac9 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from uncompress.c:21:
/localvol/usr/src/linux-2.4/include/linux/zlib_fs.h:34:19: zconf.h: No such file or directory

but the only zconf.h file is in /opt/include (and shouldn't be used anyways).

(just another datapoint on why linux should be tested on distributions
that do NOT put everything into /usr/include ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
