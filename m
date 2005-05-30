Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVE3XOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVE3XOn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVE3XLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:11:48 -0400
Received: from dev.allthingslocal.com ([69.44.58.51]:9607 "EHLO
	dev.allthingslocal.com") by vger.kernel.org with ESMTP
	id S261811AbVE3XKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:10:31 -0400
Message-ID: <429B9C49.9000900@manawiz.com>
Date: Mon, 30 May 2005 16:05:45 -0700
From: Chuck Williams <chuck@manawiz.com>
Organization: Manawiz
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de
CC: linux-kernel@vger.kernel.org, alexn@telia.com
Subject: [Bug 4688] CD devices have their capacity set incorrectly, preventing
 reading of large dvd's
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=4688


Per alexn's request, I'm mailing you a pointer to this bug.  I'm running 2.6.12-rc2 and he asked me to verify the problem still exists in rc5.  Unfortunately, I am not able to upgrade to rc5 and recompile the kernel at the moment.  I did read through the rc5 changes and a) saw no information about this bug in the changelog, and b) it appears the potentially relevant patches to ide-cd.c and block_dev.c are already in rc2.  Specifically, the hard set of capacity to ox1fffff if the stat fails is still in rc5.

I hope this is helpful,

Chuck


