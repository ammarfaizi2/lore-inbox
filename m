Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbUCSVvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 16:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbUCSVvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 16:51:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39642 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262238AbUCSVvw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 16:51:52 -0500
Message-ID: <405B6B6B.70200@pobox.com>
Date: Fri, 19 Mar 2004 16:51:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: FYI: SATA on x86-64
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There appear to be a variety of platform problems that lead to trouble 
with libata (and also with the IDE driver to some extent), with the 
default x86-64 kernel + some buggy BIOSes + some iommu weirdness.

Here are some boot options to mix and match:
	nomce, iommu=off, noapic, acpi=off

And also try using an SMP kernel (CONFIG_SMP) rather than a uniprocessor 
one.

	Jeff




