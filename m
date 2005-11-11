Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVKKKkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVKKKkB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 05:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKKKkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 05:40:01 -0500
Received: from mail.dvmed.net ([216.237.124.58]:7559 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932356AbVKKKkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 05:40:00 -0500
Message-ID: <437474FB.2030407@pobox.com>
Date: Fri, 11 Nov 2005 05:39:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: SCSI Mailing List <linux-scsi@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: SAS + Adaptec 94xx git tree updated
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Due to a horribly broken git merge, I was forced to rebase the sas-2.6 
tree against the latest upstream tree, rather than scsi-misc-2.6.

So, people interested in SAS and Adaptec 94xx, please pull from 'ALL' 
branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/sas-2.6.git

to receive Adaptec's SAS & 94xx code, plus my layering and code 
duplication fixes.

Since it needs my bare minimum merge goals -- use scsi_scan_target() and 
put host template in aic94xx -- and since the upstream SAS transport 
class may require a few changes to fully work with a all-software SAS 
stack, I'm leaning towards pushing this sooner rather than later.

That will get everybody working on the same codebase, which providing a 
working driver for hardware that's already in the field.

	Jeff



