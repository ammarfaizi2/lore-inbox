Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269296AbTCDHaV>; Tue, 4 Mar 2003 02:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269309AbTCDHaV>; Tue, 4 Mar 2003 02:30:21 -0500
Received: from adsl-67-115-104-87.dsl.sntc01.pacbell.net ([67.115.104.87]:3415
	"HELO laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S269296AbTCDHaU>; Tue, 4 Mar 2003 02:30:20 -0500
From: brian@worldcontrol.com
Date: Mon, 3 Mar 2003 23:39:39 -0800
To: linux-kernel@vger.kernel.org
Subject: Booting 2.5.63 vs 2.4.20 I can't read multicast data
Message-ID: <20030304073939.GA31394@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I give the 2.5 series a try every once in a while and found the
2.5.63 booted and ran reasonably well.

I happen to working on some multicast stuff and found that I can't
read multicast data when running 2.5.63.

Switched back to 2.4.20 and the multicast data reads fine.

Back to 2.5.63 and nada.  tcpdump shows the data showing up
at the interface.  I double checked the obvious stuff like
multicast being turned on in the kernel.

I even have tulip and rtl-8139 based cards I can switch between
and that made no difference either.

Is there something I have to set someplace to get multicast
support in 2.5.x?

-- 
Brian Litzinger
