Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUFWAJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUFWAJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 20:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbUFWAJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 20:09:57 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:43444 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265102AbUFWAJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 20:09:55 -0400
Date: Tue, 22 Jun 2004 17:09:53 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: slow performance w/patch-2.6.7-mjb1
Message-ID: <103650000.1087949393@flay>
In-Reply-To: <20040622190018.10371.qmail@web51809.mail.yahoo.com>
References: <20040622190018.10371.qmail@web51809.mail.yahoo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To the mbligh, maintainer of mjb patch sets:
> 
> I am trying to track down why I am seeing 2x in run
> time with patch-2.6.7-mjb1.  I would like to get the
> 4g/4g patch, hence the use of this patch set, however,
> something within this patch has more than doubled the
> run time for a test executable I have so I would like
> to see what component might be the cause.  Is there a
> list of the various patches that went into this patch
> set and if so, are the patches in a broken out format?

Yeah, though I'd start with "time foo" and if it's system time,
do a kernel profile. Let me know what it is, or give me a testcase ...
This is compared to 2.6.7 virgin? or -current? current code has some
wierd timer problems in mainline ... make sure to compare it to virgin.

Broken out patches are here under the patches/ subdir if you're desperate ;-)
eg: ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.7/2.6.7-mjb1

