Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267801AbUHJW7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267801AbUHJW7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUHJW7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:59:16 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:17422 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S267801AbUHJW7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:59:07 -0400
Message-ID: <41195339.9080500@superbug.demon.co.uk>
Date: Tue, 10 Aug 2004 23:59:05 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] zero downtime upgrades to the kernel.
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone investigated how one might be able to upgrade the linux 
kernel without rebooting?

We could maybe start with just being able to upgrade kernel modules 
while the modules were still in use.

E.g. There is a bug in the hard disc driver, and we have a fix, but 
don't want to reboot the machine.
Could we replace the hard disc driver while it was still being used, and 
keep mounted partitions?

James


