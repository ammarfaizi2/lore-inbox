Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbTEOOGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264041AbTEOOGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:06:01 -0400
Received: from ppp-62-245-209-2.mnet-online.de ([62.245.209.2]:22656 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S264040AbTEOOGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:06:00 -0400
Date: Thu, 15 May 2003 16:18:49 +0200
From: Julien Oster <lkml@frodoid.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.69] can't open root device on md1?
Message-ID: <20030515141849.GA1213@frodo.midearth.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after some success on other machines, I decided to boot 2.5.69 on my
main workstation.

The filesystems of that workstation are completely SoftRAID Level 1
devices, except for one which is a Level 0.

However, while booting up, the kernel refuses to mount the root
filesystem. The arrays and everything seems initialized correctly, there
are a lot of messages from the md driver as there were in 2.4.21-rc2. No
errors.

However, the 2.5.69 dies with

VFS: unable to access root device "901" or "/dev/md1"

(I haven't attached any serial console so I'm doing cut'n'paste from my
mind)

Any idea why this happens? Have the device numbers changed?

Regards,
Julien

