Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270286AbUJTWsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270286AbUJTWsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270577AbUJTWpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:45:52 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:6125 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S270488AbUJTWiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:38:14 -0400
Message-ID: <4176E8D1.9050503@nortelnetworks.com>
Date: Wed, 20 Oct 2004 16:38:09 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: why multiple definitions of SS_ONSTACK and SS_DISABLE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following two definitions are identical for every architecture that defines 
them.  Is there any particular reason why they aren't defined in linux/signal.h 
rather than asm/signal.h?

#define SS_ONSTACK	1
#define SS_DISABLE	2


Chris
