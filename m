Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVETPuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVETPuN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVETPuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:50:13 -0400
Received: from ns.suse.de ([195.135.220.2]:12504 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261472AbVETPuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:50:08 -0400
Message-ID: <428E0202.8090709@suse.de>
Date: Fri, 20 May 2005 17:28:02 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Slagter <erik@slagter.name>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: computer freezes / harddisk led stays on after S3 resume
References: <1116408408.3505.26.camel@localhost.localdomain>
In-Reply-To: <1116408408.3505.26.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Slagter wrote:
> 1. computer freezes / harddisk led stays on after S3 resume

> 7.7. Dell Inspiron 9300, Pentium M, ICH6(M), Fujitsu SATA harddisk, SONY
> ATAPI DVD+R/W. libata is running using piix according to dmesg, ahci
> doesn't work (see other problem report).

SATA had no suspend support until a few weeks ago, when Jens Axboe
started fixing it. I have no idea in which kernel version his patches
will appear, but they were on the list some days ago.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out."

