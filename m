Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbUCCS5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 13:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUCCS5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 13:57:39 -0500
Received: from 64-186-171-202-cust.nextweb.net ([64.186.171.202]:34688 "EHLO
	speedboat.skllll.net") by vger.kernel.org with ESMTP
	id S262537AbUCCS5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 13:57:38 -0500
Message-ID: <40462AA1.7010807@mvista.com>
Date: Wed, 03 Mar 2004 10:57:37 -0800
From: Steve Longerbeam <stevel@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: new special filesystem for consideration in 2.6/2.7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MontaVista Software has developed a new filesystem
targeted for embedded systems that we would like to
have considered for inclusion in 2.6 or 2.7. It is
called the Protected and Persistent RAM Special Filesystem
(PRAMFS). It was originally developed for three major consumer
electronics companies for use in their smart cell phones
and other consumer devices.

An intro to PRAMFS along with a technical specification
is at the SourceForge project web page at
http://pramfs.sourceforge.net/. A patch for 2.6.3 has
been released at the SF project site.

PRAMFS can be tested on a desktop by reserving some portion
of physical memory with "mem=". For example, a machine with
512M could reserve the top 32M with "mem=480M". PRAMFS would
then be mounted with:

mount -t pramfs -o physaddr=0x1e000000,init=0x2000000 none /mnt/pramfs

Thanks for your comments and consideration.

Steve


