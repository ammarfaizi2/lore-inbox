Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWHRAGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWHRAGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 20:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWHRAGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 20:06:46 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:38855 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S1750843AbWHRAGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 20:06:45 -0400
X-ASG-Debug-ID: 1155859604-9100-5-2
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
Reply-To: <ravinandan.arakali@neterion.com>
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: "'Chris Leech'" <christopher.leech@intel.com>,
       <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
X-ASG-Orig-Subj: I/OAT configuration ?
Subject: I/OAT configuration ?
Date: Thu, 17 Aug 2006 17:05:27 -0700
Message-ID: <003701c6c25a$034b0090$4010100a@pc.s2io.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <20060816005343.8634.21805.stgit@gitlost.site>
Importance: Normal
X-OriginalArrivalTime: 18 Aug 2006 00:05:26.0825 (UTC) FILETIME=[024F8990:01C6C25A]
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to use I/OAT on one of the newer woodcrest boxes.
But not sure if things are configured properly since there
seems to be no change in performance with I/OAT enabled
or disabled.
Following are the steps followed.
1. MSI (CONFIG_PCI_MSI) is enabled in kernel(2.6.16.21).
2. In kernel DMA configuration, following are enabled.
     Support for DMA Engines
     Network: TCP receive copy offload
     Test DMA Client
     Intel I/OAT DMA support
3. I manually load the ioatdma driver (modprobe ioatdma)

As per some documentation I read, when step #3 is performed
successfully, directories dma0chanX is supposed to be created
under /sys/class/dma but in my case, this directory stays
empty. I don't see any messages in /var/log/messages.
Any idea what is missing ?

Thanks,
Ravi


