Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267989AbUHXP2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267989AbUHXP2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUHXP2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:28:54 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:62155 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S267989AbUHXP2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:28:46 -0400
Message-ID: <412B5EB0.1000400@backtobasicsmgmt.com>
Date: Tue, 24 Aug 2004 08:28:48 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.9-rc1 compile fix: nfsroot.c
References: <20040824111751.A23041@flint.arm.linux.org.uk>
In-Reply-To: <20040824111751.A23041@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> Here's an untested patch for this error:
> 
> fs/nfs/nfsroot.c: In function `root_nfs_get_handle':
> fs/nfs/nfsroot.c:499: error: incompatible type for argument 1 of `nfs_copy_fh'
> fs/nfs/nfsroot.c:499: error: incompatible type for argument 2 of `nfs_copy_fh'

Compiled and boot-tested here successfully.
