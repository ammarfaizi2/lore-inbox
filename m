Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUJBQW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUJBQW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267304AbUJBQW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:22:29 -0400
Received: from main.gmane.org ([80.91.229.2]:58001 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267359AbUJBQUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:20:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Sherman <adam@sherman.ca>
Subject: DMA timeout error
Date: Fri, 01 Oct 2004 14:56:42 -0400
Message-ID: <cjmk3s$gjs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe000c41aab295-cm000f9fa6ba66.cpe.net.cable.rogers.com
User-Agent: Mozilla Thunderbird 0.8 (Macintosh/20040913)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a VIA M6000 board with an ATA CompactFlash adaptor containing a
512MB SanDisk card.

I get the following error during boot:

hdb: dma_timer_expiry: dma status == 0x41
hdb: DMA timeout error
hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdb: drive not ready for command
hdb: dma_timer_expiry: dma status == 0x41
hdb: DMA timeout error
hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdb: drive not ready for command


Any ideas?

Thanks,

A.


