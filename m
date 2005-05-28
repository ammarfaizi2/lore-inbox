Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVE1DpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVE1DpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 23:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVE1DpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 23:45:11 -0400
Received: from mail.dvmed.net ([216.237.124.58]:31202 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261820AbVE1DpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 23:45:06 -0400
Message-ID: <4297E93D.2060003@pobox.com>
Date: Fri, 27 May 2005 23:45:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: netdev-2.6, wireless queues updated
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The net driver change queue has been updated, most notably with some new 
wireless drivers and wireless stack updates.

Intel contributed drivers for their Centrino hardware, "ipw2100" and 
"ipw2200".  SuSE has begun contributing work that advances the ieee80211 
stack work, taking it much closer to the goal of having ieee802.11 
support fully integrated into the network stack as "real" protocol layer.


Git repository containing a great many branches:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

The branch of note for wireless developers is currently 'we18-ieee80211'.

Git instructions, for those needing an introduction:
http://lkml.org/lkml/2005/5/26/11

And finally a patch containing _only_ the changes on the we18-ieee80211 
branch,
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.12-rc5-git2-ieee80211-1.patch.bz2

Notably, this patch does not include HostAP, which is stored in a child 
branch 'we18-ieee80211-wifi'.


