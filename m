Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVCPHea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVCPHea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 02:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVCPHea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 02:34:30 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:61192 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S262543AbVCPHeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 02:34:21 -0500
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Intel Ethernet PRO 100
In-Reply-To: <423703F7.1090107@osdl.org>
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.11 (i686))
Message-Id: <E1DBT2p-0003xd-9x@rhn.tartu-labor>
Date: Wed, 16 Mar 2005 09:34:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>        Where we can find specs for writing driver for Intel PRO 100 card.

RD> You can find a developer's manual for the 8255x NIC at
RD> http://sourceforge.net/project/showfiles.php?group_id=42302

I'. not sure what NIC the original poster meant, but:

PRO 100 is actually an older card than e100 supports. e100 supports Pro
100+ and other newer cards. Original Pro 100 used 82556 but this doc
(and e100) is about 82557 and newer chips.

The PCI ID of 82556-based pro 100 smart was just removed from eepro100
driver too because it didn't actually work. I have two of these cards
and tested myself that they did not work.

-- 
Meelis Roos
