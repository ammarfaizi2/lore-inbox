Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbULRUyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbULRUyP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 15:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbULRUyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 15:54:15 -0500
Received: from smtp08.web.de ([217.72.192.226]:691 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S261155AbULRUyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 15:54:13 -0500
Message-ID: <41C498F2.7070603@web.de>
Date: Sat, 18 Dec 2004 21:54:10 +0100
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SWSUSP in 2.6.9 and 2.6.9-ac16 screws up the swap
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Toshiba Satelite M30X laptop for which suspend-to-disk is 
reported to work. I tested with kernel 2.6.9 vanilla and -ac16 and 
suspending seemed to work ok, at least the computer shut down. On 
resuming I appended "resume=/dev/hda3" (my swap partition) to the boot 
options but saw no message about resuming form suspend image ot 
anything, it seems to be a normal boot. Later on when adding swap I got 
the error "Unable to find swap-space signature", `cat /proc/swaps` 
didn't show anything. I had to recreate the swap.

Could anyone please look into this? I would provide any additional 
information requested. Please Cc: me when you answer. Thanks in advance.

T.Todorov

