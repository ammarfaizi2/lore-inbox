Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135941AbRDZV35>; Thu, 26 Apr 2001 17:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135942AbRDZV3u>; Thu, 26 Apr 2001 17:29:50 -0400
Received: from cc885639-a.flushing1.mi.home.com ([24.182.96.34]:18436 "HELO
	caesar.lynix.com") by vger.kernel.org with SMTP id <S135941AbRDZV33>;
	Thu, 26 Apr 2001 17:29:29 -0400
Date: Thu, 26 Apr 2001 17:30:16 +0000
From: Subba Rao <subba9@home.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: init process in 2.2.19
Message-ID: <20010426173016.C1125@home.com>
Reply-To: Subba Rao <subba9@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to add a process which is to be managed by init. I have added the
following entry to /etc/inittab

SV:2345:respawn:env - PATH=/usr/local/bin:/usr/sbin:/usr/bin:/bin svscan /service </dev/null 2> dev/console

After saving, I execute the following command:

	# kill -HUP 1

This does not start the process I have added. The process that I have added
only starts when I do:

	# init u
or
	# telinit u

PS - The process will not start even after a reboot. I have to manually do one
of the above commands as root.

My kernel version is : 2.2.19
Distro : Slackware
GCC : gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

Any help appreciated.

-- 

Subba Rao
subba9@home.com
http://members.home.net/subba9/

GPG public key ID 27FC9217
