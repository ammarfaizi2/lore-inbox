Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVEMDIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVEMDIz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 23:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVEMDIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 23:08:55 -0400
Received: from mail.dvmed.net ([216.237.124.58]:51921 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262222AbVEMDIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 23:08:53 -0400
Message-ID: <42841A3F.7020909@pobox.com>
Date: Thu, 12 May 2005 23:08:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: git repository for net drivers available
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Although I have over 200 net driver patches to go through in my 
'Pending' folder, I have fully converted the existing netdev-2.6 
repository from BitKeeper to git.  This includes the wireless-2.6 
repository.

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

The main branch is fairly irrelevant, as you must choose the branch you 
wish:
> [jgarzik@pretzel netdev-2.6]$ ls .git/branches/
> 8139cp         e1000        ixgb     r8169            skge           we18
> 8139too-iomap  forcedeth    janitor  register-netdev  smc91x         wifi
> amd8111        ieee80211    orinoco  remove-drivers   smc91x-eeprom
> e100           iff-running  ppp      sis900           starfire


For folks looking for a consolidated netdev-2.6 repository (hi Andrew), 
that does not exist yet.  I will create an 'ALL' repository for this 
purpose, sometime soon.

	Jeff



