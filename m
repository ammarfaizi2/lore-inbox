Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268981AbUJQFZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268981AbUJQFZs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 01:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269056AbUJQFZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 01:25:48 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:56770 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268981AbUJQFZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 01:25:47 -0400
Message-ID: <41720210.1090706@biomail.ucsd.edu>
Date: Sat, 16 Oct 2004 22:24:32 -0700
From: John Gilbert <jgilbert@biomail.ucsd.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ATI drivers and 2.6.9-rc4+
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I've fixed svgalib drivers and got them working under 2.6.9-rc4+ by 
replacing "pci_find_class" with "pci_get_class".
The ATI closed drivers have a problem with "remap_page_range". What does 
this translate into (if it's that simple)?
This seems to have changed from 2.6.8.
Thanks in advance.
John Gilbert
jgilbert@biomail.ucsd.edu
