Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315599AbSFCWDl>; Mon, 3 Jun 2002 18:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315606AbSFCWDk>; Mon, 3 Jun 2002 18:03:40 -0400
Received: from [213.4.129.129] ([213.4.129.129]:1766 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id <S315599AbSFCWDk>;
	Mon, 3 Jun 2002 18:03:40 -0400
Date: Tue, 4 Jun 2002 00:04:21 +0200
From: Diego Calleja <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: ALSA cmi8330 start fails
Message-Id: <20020604000421.59a728e3.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the output of dmesg compiling the cim8330 ISA driver (ALSA):

May 30 20:32:55 localhost kernel: ALSA mpu401.c:68: specify snd_port
May 30 20:32:55 localhost kernel: ALSA cmi8330.c:318: specify
snd_wssport

This should not happen as I've isapnp and the cim8330 driver compiled
inside the kernel (not as modules)

in 2.5.19 happens, not tested others
