Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVAXETr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVAXETr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 23:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVAXETr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 23:19:47 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:58840 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261426AbVAXETq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 23:19:46 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Date: Mon, 24 Jan 2005 15:19:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16884.30557.631532.32864@cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: md and RAID 5 [was Re: LVM2]
In-Reply-To: message from Trever L. Adams on Friday January 21
References: <1106250687.3413.6.camel@localhost.localdomain>
	<1106336028.3369.4.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday January 21, tadams-lists@myrealbox.com wrote:
> Thank you all for having been so kind in your responses and help.
> 
> However, there is one more set of questions I have.
> 
> Does the md (software raid) have disk size or raid volume limits?

2^31 sectors for individual disks.  Arrays do not have this limit.

> 
> If I am using such things as USB or 1394 disks, is there a way to use
> labels in /etc/raidtab and with the tools so that when the disks, if
> they do, get renumbered in /dev that all works fine. I am aware that the
> kernel will autodetect these devices, but that the raidtab needs to be
> consistent. This is what I am trying to figure out how to do.

Scrap raidtools and /etc/raidtab.  Explore "mdadm" and /etc/mdadm.conf

NeilBrown
