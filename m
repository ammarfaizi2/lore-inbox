Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUHaQqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUHaQqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUHaQqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:46:24 -0400
Received: from mail.stdbev.com ([63.161.72.3]:35484 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S263893AbUHaQqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:46:18 -0400
Message-ID: <d40d2dbcd4c9aaaeb94073ca00d7b3b7@stdbev.com>
Date: Tue, 31 Aug 2004 11:54:00 -0500
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: 2.6.9-rc1-mm2 nvidia breakage
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Reply-to: <jason@stdbev.com>
In-Reply-To: <4134A5EE.5090003@blueyonder.co.uk>
References: <4134A5EE.5090003@blueyonder.co.uk>
X-Mailer: Hastymail 1.3-CVS
x-priority: 3
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:23:10 am 2004-08-31 Sid Boyce <sboyce@blueyonder.co.uk> wrote:
nvidia-installer log file '/var/log/nvidia-installer.log'
creation time: Tue Aug 31 17:05:05 2004

[snip]

   `PM_SAVE_STATE' undeclared (first use in this function)
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c:3697:


A patch was posted a week or so ago to fix this which works for me.

http://lkml.org/lkml/2004/8/20/209

I also had to change calls to pci_find_class in nv.c to pci_get_class to
get the module to load with 2.6.9-rc1-mm2.

Hope that helps

\__ Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/

