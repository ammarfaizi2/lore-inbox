Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265678AbUGDNpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUGDNpW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 09:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUGDNpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 09:45:22 -0400
Received: from mx1.magmacom.com ([206.191.0.217]:23262 "EHLO mx1.magmacom.com")
	by vger.kernel.org with ESMTP id S265678AbUGDNpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 09:45:17 -0400
Subject: Re: [BUG] FAT broken in 2.6.7-bk15
From: Jesse Stockall <stockall@magma.ca>
To: Ali Akcaagac <aliakc@web.de>
Cc: linux-kernel@vger.kernel.org, linux-msdos@vger.kernel.org
In-Reply-To: <1088940508.655.6.camel@localhost>
References: <1088940508.655.6.camel@localhost>
Content-Type: text/plain
Message-Id: <1088948649.9600.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 04 Jul 2004 09:44:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-04 at 07:28, Ali Akcaagac wrote:
> Hello,
> 
> The recent changes in 2.6.7-bk15 broke FAT support. I am doing some
> rescue backup systems here using tools like syslinux and mtools to
> format a normal msdos disk (for el-torito). I figured out that after
> creating and formating of these disks that it is impossible to mount
> them with 'msdos' or 'vfat'. Even recompiling mtools with current
> changes show the same issues. Please someone check up and fix the issues
> (maybe reverting the changes).

Check syslog for error messages, I had a similar problem due to the
codepage module not being loaded. Sometime after 2.6.7 there were config
changes for FAT default codepage.

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

