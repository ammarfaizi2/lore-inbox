Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTLPT3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 14:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLPT3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 14:29:40 -0500
Received: from 213-0-194-193.dialup.nuria.telefonica-data.net ([213.0.194.193]:24964
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S262130AbTLPT3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 14:29:38 -0500
Date: Tue, 16 Dec 2003 20:29:35 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need Quota Support for Reiserfs Partition
Message-ID: <20031216192935.GA3084@localhost>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <01a901c3c2a7$f5d8a9d0$0900a8c0@BOBHITT> <20031215085312.GD6613@atrey.karlin.mff.cuni.cz> <3FDF2632.C83B80D7@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDF2632.C83B80D7@bull.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 16 December 2003, at 16:35:14 +0100,
Jacky Malcles wrote:

> do you know if quotas are working with ext3 FS ?
>
Yes, they work, I have just tested it over a LV block-device.

> I'm using kernel 2.6.0test9 and quota-3.09-1
>
kernel version 2.6.0-test10-mm1 and 3.09-3 (Debian Sid) here.

> and I  can't turn them on,
>
Did you mount the filesystem with "-o usrquota,grpquota" ?. Do you
compiled support for generic quotas and for the quota version (V2) you
seem to be using (module quota_v2) ?.

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test10-mm1)
