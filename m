Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTLUKOK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 05:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTLUKOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 05:14:10 -0500
Received: from 217-124-47-72.dialup.nuria.telefonica-data.net ([217.124.47.72]:64129
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S262446AbTLUKOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 05:14:08 -0500
Date: Sun, 21 Dec 2003 11:14:06 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Cc: Dale Amon <amon@vnl.com>
Subject: Re: Is there still at 2TB limit?
Message-ID: <20031221101406.GA3211@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Dale Amon <amon@vnl.com>
References: <20031221010112.GX25351@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221010112.GX25351@vnl.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 21 December 2003, at 01:01:12 +0000,
Dale Amon wrote:

> Is this standard in 2.6.0 kernels? What filesystem size
> and file size limits are there currently?
> 
In 2.6.x kernels you are also limited by the 2 TiB limit on block device
sizes, limit which you can extend compiling a 2.6.x kernel with "Large
Block Device" support (menu "Device Drivers" -> "Block devices", at the end).

You will also need filesystems that support that big sizes and can hold
big files on them, have a look at the following URL for more information:
http://www.suse.de/~aj/linux_lfs.html

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0)
