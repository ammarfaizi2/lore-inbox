Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbTGOTfz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269633AbTGOTfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:35:55 -0400
Received: from 217-124-18-158.dialup.nuria.telefonica-data.net ([217.124.18.158]:64656
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S269621AbTGOTfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:35:52 -0400
Date: Tue, 15 Jul 2003 21:26:21 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Joe Pranevich <jpranevich@lycos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wonderful World of Linux 2.6 - Linux 2.6 features document (first revision)
Message-ID: <20030715192621.GA3855@localhost>
Mail-Followup-To: Joe Pranevich <jpranevich@lycos.com>,
	linux-kernel@vger.kernel.org
References: <GCCBBPJABOOLMBAA@mailcity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GCCBBPJABOOLMBAA@mailcity.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 14 July 2003, at 10:24:39 -0400,
Joe Pranevich wrote:

> Please let me know what you think. 
> 
First of all, thank you for the great work you have done again, it is
worth each line :-). Now, a couple of corrections:

"And finally, Linux 2.6 will include improved 64-bit support
on block devices that support it, even on 32-bit platforms such as i386.
This allows for filesystems up to 2TB."

This should read "This allows for filesystems greater than 2 TB", or
even better "This allows for block devices greater than 2 TB". I think
maximun block device and filesytem sizes are independent, but I could be
wrong, because I am not an expert :)

And now, an omission. Linux kernel 2.4.x had LVM1, and has been replaced
by DM (Device Mapper), that is said to be a better thought
implementation of the same concept. The nice part is DM in 2.6.0 will be
able to activate and drive 2.4.x LV (Logical Volumes), provided a recent
version of the LVM2 userspace tools are used.

Apart from this, I think EVMS (Enterprise Volume Management System)
deserves some credit. It was never included in standard 2.4.x kernels,
but now that EVMS userspace tools use DM (as LVM2 does) and provide for
a complete disk management system, maybe it also could have a little
place in your excellent document.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test1)
