Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbUBEOGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 09:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbUBEOGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 09:06:40 -0500
Received: from srv1a-cta.bs2.com.br ([200.203.183.35]:13841 "EHLO
	srv1a-cta.bs2.com.br") by vger.kernel.org with ESMTP
	id S265264AbUBEOGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 09:06:37 -0500
Message-ID: <402244FE.5010107@gardenali.biz>
Date: Thu, 05 Feb 2004 11:28:30 -0200
From: Evaldo Gardenali <evaldo@gardenali.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problem on __alloc_pages
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.
I am a newbie to kernel memory alloc, and got this on my server.

Feb  5 11:09:39 server1 kernel: __alloc_pages: 1-order allocation failed
(gfp=0x1f0/0)
Feb  5 11:09:39 server1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1f0/0)
Feb  5 11:10:36 server1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0)
Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0)
Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0)
Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0xf0/0)
Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0)
Fev  5 11:11:39 server1 gconfd (evaldo-2337): Recebido sinal 15,
desligando corretamente
Fev  5 11:11:40 server1 gconfd (evaldo-2337): Terminando
Feb  5 11:11:52 server1 /usr/sbin/gpm[437]: imps2: Auto-detected
intellimouse PS/2
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@Feb  5 11:13:12 server1
syslogd 1.4.1: restart.

(server reboot)

my server runs like this normally:
~        total:    used:    free:  shared: buffers:  cached:
Mem:  527372288 422723584 104648704        0 45375488 222887936
Swap: 978726912        0 978726912
MemTotal:       515012 kB
MemFree:        102196 kB
MemShared:           0 kB
Buffers:         44312 kB
Cached:         217664 kB
SwapCached:          0 kB
Active:          58560 kB
Inactive:       325604 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       515012 kB
LowFree:        102196 kB
SwapTotal:      955788 kB
SwapFree:       955788 kB

Linux server1 2.4.25-pre6-athlonxp #1 Tue Jan 20 11:49:48 BRST 2004 i686
unknown unknown GNU/Linux
"-athlonxp" is just a descriptive name, for me to differentiate my
kernels. no extra patch was made

Thanks
Evaldo Gardenali
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAIkT95121Y+8pAbIRAsmYAJwLAsTxZ2S6Q+RKQ//6l+Qrv25VXwCdHrTd
2+wNbdm7uNFfAUcYMG+g+qI=
=EyDh
-----END PGP SIGNATURE-----
