Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTJLIdN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 04:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTJLIdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 04:33:12 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:45828 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S263432AbTJLIdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 04:33:11 -0400
To: linux-kernel@vger.kernel.org
Path: 127.0.0.1!nobody
From: Peter Matthias <espi@epost.de>
Newsgroups: linux.kernel
Subject: Re: ACM USB modem on Kernel 2.6.0-test
Date: Sun, 12 Oct 2003 10:40:26 +0200
Organization: Tiscali Germany
Message-ID: <q14bmb.j9.ln@127.0.0.1>
References: <FwYB.Z9.25@gated-at.bofh.it>
NNTP-Posting-Host: p62.246.112.66.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1065947478 65727 62.246.112.66 (12 Oct 2003 08:31:18 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Sun, 12 Oct 2003 08:31:18 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell schrieb:

>> usb 3-3: configuration #1 chosen from 2 choices
>> drivers/usb/class/cdc-acm.c: need inactive config #2
>> drivers/usb/class/cdc-acm.c: need inactive config #2
> 
> Until we get more intelligence somewhere, do this:
> 
>     # cd /sys/bus/usb/devices/3-3
>     # echo '2' > bConfigurationValue
>     #

Sound good, but I don't have /sys/ (nor do I have /proc/sys/bus/) with the
OHCI driver.

Peter
