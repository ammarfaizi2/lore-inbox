Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTEWU50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTEWU50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:57:26 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:14572 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S264188AbTEWU5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:57:25 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: Linux 2.4.21-rc3 [net-pf-4, devfs audio, drm radeon]
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
Organization: Who, me?
User-Agent: tin/1.5.18-20030515 ("Peephole") (UNIX) (Linux/2.4.21-rc3-gzp2 (i686))
Message-ID: <4698.3ece8e46.c94d4@gzp1.gzp.hu>
Date: Fri, 23 May 2003 21:10:30 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti <marcelo@conectiva.com.br>:

| Here goes the third release candidate of 2.4.21.

A few comments:

kmod: failed to exec /sbin/modprobe -s -k net-pf-4, errno = 2

appears since 2.4.18 or so, dunno what really mean.
net-pf-4 set to off in modules.conf...

devfs_register(audio): could not append to parent, err: -17

New in -rc3. Soundcard:
02:09.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
Using alsa driver 0.9.3c.

And finally:

[drm] Initialized radeon 1.1.1 20010405 on minor 0
[drm:radeon_unlock] *ERROR* Process 100 using kernel context 0

00:01.0 PCI bridge: Intel Corp. 82830 830 Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])

