Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTJLR5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 13:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTJLR5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 13:57:30 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:54020 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S263496AbTJLR53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 13:57:29 -0400
To: linux-kernel@vger.kernel.org
Path: 127.0.0.1!nobody
From: Peter Matthias <espi@epost.de>
Newsgroups: linux.kernel
Subject: Re: ACM USB modem on Kernel 2.6.0-test
Date: Sun, 12 Oct 2003 19:52:39 +0200
Organization: Tiscali Germany
Message-ID: <7d4cmb.j9.ln@127.0.0.1>
References: <FwYB.Z9.25@gated-at.bofh.it>
NNTP-Posting-Host: 62.246.102.237
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1065981332 73129 62.246.102.237 (12 Oct 2003 17:55:32 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Sun, 12 Oct 2003 17:55:32 +0000 (UTC)
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
Thanks, it now works when I load the cdc-acm module after that.

Peter
