Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUBQGMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbUBQGMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:12:08 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:6809 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266048AbUBQGJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:09:43 -0500
Message-ID: <4031B01B.80006@t-online.de>
Date: Tue, 17 Feb 2004 07:09:31 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ryan Reich <ryanr@uchicago.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
References: <1pw4i-hM-27@gated-at.bofh.it> <1pw4i-hM-29@gated-at.bofh.it> <1pw4i-hM-31@gated-at.bofh.it> <1pw4i-hM-25@gated-at.bofh.it> <1pLmG-4E7-5@gated-at.bofh.it> <1pRLz-21o-33@gated-at.bofh.it> <1pRVi-2am-27@gated-at.bofh.it> <1pWi8-65a-11@gated-at.bofh.it> <40315225.3010104@uchicago.edu>
In-Reply-To: <40315225.3010104@uchicago.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: bVgYhiZageSuXQvR+bfypANeroHgm9DlWE5skPgqBayuE9uCnNUhYE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Reich wrote:

 > Anyway, if you really want to correct the inconsistencies you need only
 > edit the sources for the modules in question; the names which appear in
 > /proc/modules appear to be defined in, for example,
 > drivers/usb/host/uhci-hcd.c, where the .description section of the module
 > is set. Or change the filenames, though I don't know how that will fly with
 > the make process.
 >

Of course I could patch the kernel sources to remove the
inconsistencies in the module names. But IMHO it is much
more important to convince the kernel developers that this
inconsistency is bad.


Regards

Harri
