Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVHHPKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVHHPKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVHHPKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:10:38 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:31364 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750936AbVHHPKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:10:38 -0400
Message-ID: <42F775F6.8090600@gmail.com>
Date: Mon, 08 Aug 2005 17:10:46 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/video/sis/ macros for old kernels removal
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some #ifs, which controls kernel version (2.4 or 
like), so the code could be removed with the macros.
linux/version.h inclusions also removed.

 init.h      |    5
 init301.h   |    5
 sis.h       |   46 ---
 sis_accel.c |  243 ------------------
 sis_accel.h |   13 -
 sis_main.c  |  780 
------------------------------------------------------------
 sis_main.h  |   55 ----
 vgatypes.h  |    2
 8 files changed, 2 insertions(+), 1147 deletions(-)

patch is here (45 KiB):
http://www.fi.muni.cz/~xslaby/lnx/sis_macros.txt

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

