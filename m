Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVBAAaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVBAAaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVBAA2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:28:20 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:48777 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261496AbVBAAP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:15:28 -0500
Message-ID: <41FECA18.50609@nortelnetworks.com>
Date: Mon, 31 Jan 2005 18:15:20 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
Subject: question on symbol exports
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that in 2.6.9 the ppc64 version of flush_tlb_page() depends 
on two symbols which are not currently exported: the function 
__flush_tlb_pending(), and the per-cpu variable ppc64_tlb_batch.

Is there any particular reason why modules should not be allowed to 
flush the tlb, or is this an oversight?

Chris
