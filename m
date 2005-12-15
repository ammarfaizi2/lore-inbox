Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVLOWI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVLOWI7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVLOWI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:08:59 -0500
Received: from zrtps0kp.nortelnetworks.com ([47.140.192.56]:34494 "EHLO
	zrtps0kp.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751155AbVLOWI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:08:58 -0500
Message-ID: <43A1E960.7070904@nortel.com>
Date: Thu, 15 Dec 2005 16:08:32 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to free bootmem-allocated memory after system is up?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2005 22:08:33.0609 (UTC) FILETIME=[16E6F390:01C601C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got some memory that was allocated very early on using the bootmem API.

Later on in the boot sequence I determine that I don't actually need 
that memory, but the bootmem bitmaps have been torn down.

Is there any way to tell the memory subsystem, "by the way, here are a 
bunch of pages that you can use that you didn't know about before"?

Chris
