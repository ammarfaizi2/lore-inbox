Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTJCP5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 11:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263757AbTJCP5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 11:57:53 -0400
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:20921 "EHLO
	office.lsg.internal") by vger.kernel.org with ESMTP id S263617AbTJCP5w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 11:57:52 -0400
Message-ID: <3F7D9C83.4050200@backtobasicsmgmt.com>
Date: Fri, 03 Oct 2003 08:57:55 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: libata support for Adaptec 1205SA?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to add some SATA ports to a system, not RAID, just plain SATA 
ports. I've found the SIIG SC-SAT212 which is based on the Sil3112A 
chip, but may not fit in my low-profile case. There is also the 
Adaptec 1205SA which already is a low-profile card, but I can't seem 
to find any information on the 'net as to which chip it uses.

Does anyone here know, and more importantly, is libata ready to 
support it? I want to build a 6-drive SATA RAID using software RAID 5 
(can't just the expense of a 3ware card for this application), so I 
need to add four ports to the two already present on an ICH5 on the 
motherboard.

