Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbUHQM1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUHQM1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUHQM1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:27:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2762 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265981AbUHQM1J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:27:09 -0400
Message-ID: <4121F991.4000004@pobox.com>
Date: Tue, 17 Aug 2004 08:26:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ethtool version 2 released
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just released a small update to ethtool, version 2, posted at

	http://sourceforge.net/projects/gkernel/

Like its cousin "blktool", ethtool now has a simplified version scheme, 
an ascending number.

For those unfamiliar with ethtool, it is a utility designed to configure 
specific features founds on most ethernet cards.

Summary of changes (mainly the new version scheme):

         * Feature: ethtool register dump raw mode
         * Feature: return results of self-test back to OS via exit(2)
         * Feature: add verbose register dump for pcnet32, fec_8xx
         * Maintenance: update to more recent autoconf
         * Maintenance: minor updates to e1000-specific module
         * Bug fix: Remove silly restriction on ethernet interface naming


