Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSKDSId>; Mon, 4 Nov 2002 13:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262453AbSKDSIc>; Mon, 4 Nov 2002 13:08:32 -0500
Received: from [208.48.139.185] ([208.48.139.185]:39810 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S262446AbSKDSIc>; Mon, 4 Nov 2002 13:08:32 -0500
Date: Mon, 4 Nov 2002 10:15:01 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Spontaneous Call Trace?
Message-ID: <20021104101501.A812@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just encountered a dual CPU machine running 2.4.18 with the NFS_ALL and
xfs patch which spontaneously generated two complete call traces over the
weekend.  There was no Oops or kernel bug recorded in the syslog although
syslog functionality remained intact.  After this point functionality on the
system was degraded (various processes were not accepting new connections)
and we rebooted the system.  We're planning on upgrading to 2.4.19 with the
NFS_ALL and ext3-all patches ASAP.

I've never seen this type of behavior before in my years of using Linux, has
anyone else?  BTW, sysrq is disabled on the machine...

-Dave
