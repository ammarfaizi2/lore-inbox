Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293048AbSDDShY>; Thu, 4 Apr 2002 13:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292957AbSDDShO>; Thu, 4 Apr 2002 13:37:14 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:46663 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S293048AbSDDShE>; Thu, 4 Apr 2002 13:37:04 -0500
From: brian@worldcontrol.com
Date: Thu, 4 Apr 2002 10:34:11 -0800
To: linux-kernel@vger.kernel.org
Subject: raid,apm,ide, powers down too fast & corrupts raid
Message-ID: <20020404183410.GA2904@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I power off a system running bootable software RAID mirroring the
raid array is unclean when the system boots back up.

Neil Brown pointed out that the problem may be related to APM shutting
the computer off before everybody (md driver and/or ide and/or drives)
are ready.

Compiling the kernel without APM/ACPI support certainly solves the
problem.

I'm running Linux 2.4.18 on this system.  Has this problem been
addressed in any later versions?

Or shall I start exploring the APM, ide driver, md driver, ide
drive interactions?

--
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2002 By Brian Litzinger, All Rights Reserved
