Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263786AbUD0Ft1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbUD0Ft1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUD0Ft1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:49:27 -0400
Received: from [194.89.250.117] ([194.89.250.117]:43403 "EHLO
	kimputer.holviala.com") by vger.kernel.org with ESMTP
	id S263786AbUD0FtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:49:24 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Troubleshooting PS/2 mouse in 2.6.5
Date: Tue, 27 Apr 2004 08:49:23 +0300
User-Agent: KMail/1.6.1
References: <408D4CB4.4070901@chen-becker.org>
In-Reply-To: <408D4CB4.4070901@chen-becker.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404270849.23397.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 April 2004 20:53, Derek Chen-Becker wrote:

>      I'm upgrading my workstation from 2.4.22 to 2.6.5 and everything is
> working great except for /dev/input/mice: it doesn't appear to be
> producing anything, even if I cat it. I've checked and both dmesg and
> /proc/bus/input/devices show the mouse handler loaded and show the mouse
> as recognized.

What do the system logs say? I suggest you build psmouse into a module so that 
you can modprobe/rmmod it to test stuff without rebooting.




Kim
