Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269858AbTGKJm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269861AbTGKJm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:42:58 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:1805 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S269858AbTGKJm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:42:58 -0400
Date: Fri, 11 Jul 2003 10:57:39 +0100
From: Joe Thornber <thornber@sistina.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Cc: thornber@sistina.com
Subject: device-mapper v4 ioctl interface patchset
Message-ID: <20030711095739.GA9111@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please merge.

These 2 patches implement the new ioctl interface for device-mapper.
This new interface is selectable with a config option, people can
continue to use the v1 interface if they wish.

The main issues that v4 addresses are:

i)  ioctl structure size issues on different architectures.

ii) tables can now be preloaded to avoid having to allocate memory
    while devices are suspended.

iii) Fix a userland race condition associated with the 'wait for
     event' ioctl.


- Joe
