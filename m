Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267343AbUHYOrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUHYOrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267594AbUHYOrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:47:17 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:8587 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267343AbUHYOpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:45:20 -0400
Message-ID: <412CA5F5.6000006@nortelnetworks.com>
Date: Wed, 25 Aug 2004 10:45:09 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've run into a problem enabling CONFIG_IEEE1394_SBP2_PHYS_DMA for ppc64.  The
sbp2_handle_physdma_write() and _read() functions use bus_to_virt(), which 
doesn't appear to exist for ppc64.  Turning off the debug config parm enables 
the compile to proceed.

Chris

