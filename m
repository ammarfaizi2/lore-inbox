Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVCBMzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVCBMzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 07:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVCBMzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 07:55:22 -0500
Received: from smtp1.sloane.cz ([62.240.161.228]:53476 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S262287AbVCBMzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 07:55:04 -0500
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: smartlink alsa modem problem in 2.6.11
Date: Wed, 2 Mar 2005 13:54:37 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503021354.38603.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried use snd_intel8x0m  with smartlink modem, but without success:

Mar  2 13:49:15 notas kernel: CSLIP: code copyright 1989 Regents of the 
University of California
Mar  2 13:49:15 notas kernel: PPP generic driver version 2.4.2
Mar  2 13:49:35 notas pppd[5169]: pppd 2.4.2 started by root, uid 0
Mar  2 13:49:36 notas chat[5171]: timeout set to 5 seconds
Mar  2 13:49:36 notas chat[5171]: abort on (BUSY)
Mar  2 13:49:36 notas chat[5171]: abort on (NO CARRIER)
Mar  2 13:49:36 notas chat[5171]: abort on (VOICE)
Mar  2 13:49:36 notas chat[5171]: abort on (NO DIALTONE)
Mar  2 13:49:36 notas chat[5171]: send (^MATZ^M)
Mar  2 13:49:36 notas chat[5171]: expect (OK)
Mar  2 13:49:36 notas chat[5171]: ^M^M^MATZ^M^M
Mar  2 13:49:36 notas chat[5171]: OK
Mar  2 13:49:36 notas chat[5171]:  -- got it
Mar  2 13:49:36 notas chat[5171]: send (ATZX1^M)
Mar  2 13:49:37 notas chat[5171]: expect (OK)
Mar  2 13:49:37 notas chat[5171]: ^M
Mar  2 13:49:37 notas chat[5171]: ATZX1^M^M
Mar  2 13:49:37 notas chat[5171]: OK
Mar  2 13:49:37 notas chat[5171]:  -- got it
Mar  2 13:49:37 notas chat[5171]: send (ATX3^M)
Mar  2 13:49:37 notas chat[5171]: expect (OK)
Mar  2 13:49:37 notas chat[5171]: ^M
Mar  2 13:49:37 notas chat[5171]: ATX3^M^M
Mar  2 13:49:37 notas chat[5171]: OK
Mar  2 13:49:37 notas chat[5171]:  -- got it
Mar  2 13:49:37 notas chat[5171]: send (ATDT 971200111^M)
Mar  2 13:49:37 notas chat[5171]: timeout set to 60 seconds
Mar  2 13:49:37 notas chat[5171]: expect (CONNECT)
Mar  2 13:49:37 notas chat[5171]: ^M
Mar  2 13:49:37 notas chat[5171]: ATDT 971200111^M^M
Mar  2 13:49:37 notas kernel: codec_semaphore: semaphore is not ready [0x1]
[0x701300]
Mar  2 13:49:37 notas kernel: codec_write 1: semaphore is not ready for 
register 0x54
Mar  2 13:49:37 notas kernel: codec_semaphore: semaphore is not ready [0x1]
[0x700300]
Mar  2 13:49:37 notas kernel: codec_write 1: semaphore is not ready for 
register 0x54
Mar  2 13:50:25 notas pppd[5169]: Terminating on signal 15.
Mar  2 13:50:25 notas chat[5171]: SIGTERM
Mar  2 13:50:25 notas pppd[5169]: Connect script failed
Mar  2 13:50:26 notas pppd[5169]: Exit.
Mar  2 13:50:40 notas kernel: codec_semaphore: semaphore is not ready [0x1]
[0x700304]
Mar  2 13:50:40 notas kernel: codec_write 1: semaphore is not ready for 
register 0x54


slamr.ko works fine

Michal Semler
