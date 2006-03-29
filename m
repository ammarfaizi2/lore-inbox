Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWC2R6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWC2R6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 12:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWC2R6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 12:58:51 -0500
Received: from zrtps0kn.nortel.com ([47.140.192.55]:17044 "EHLO
	zrtps0kn.nortel.com") by vger.kernel.org with ESMTP
	id S1750924AbWC2R6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 12:58:51 -0500
Message-ID: <442ACAD6.6@nortel.com>
Date: Wed, 29 Mar 2006 11:58:46 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CONFIG_FRAME_POINTER and module vermagic
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Mar 2006 17:58:48.0074 (UTC) FILETIME=[6DC9C6A0:01C6535A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've had a case reported to me of someone loading a module without frame 
pointers into kernel compiled with frame pointers enabled.

1) Is this allowed?  I didn't think so, but I wanted to double check.
2) If not, would it make sense to include this in the module vermagic?

Thanks,

Chris
