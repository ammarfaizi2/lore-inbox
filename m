Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261601AbREUGjw>; Mon, 21 May 2001 02:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbREUGjc>; Mon, 21 May 2001 02:39:32 -0400
Received: from mailo.vtcif.telstra.com.au ([202.12.144.17]:50920 "EHLO
	mailo.vtcif.telstra.com.au") by vger.kernel.org with ESMTP
	id <S261601AbREUGjZ>; Mon, 21 May 2001 02:39:25 -0400
From: Allan Duncan <b372050@vus068.trl.telstra.com.au>
Message-Id: <200105210638.QAA19887@vus068.trl.telstra.com.au>
Subject: compile failure in 2.4.5-pre4
To: linux-kernel@vger.kernel.org
Date: Mon, 21 May 101 16:38:45 +1000 (EST)
X-Mailer: ELM [version 2.4 PL23]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This addition for 2.4.5-pre4 has caused a compile failure with a parsing error:

drivers/ide/ide-pci.c:711
    		if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530)

In my case CONFIG_BLK_DEV_CS5530 is not defined.

-- 
Allan Duncan  b372050@vus068.trl.telstra.com.au  (+613) 9253 6708, Fax 9253 6775
     (We are just a number)
 Next Generation Infrastructure Program - Transport Architecture Project
Telstra Research Labs, Box 249 Rosebank MDC, Clayton, Victoria, 3169, Australia
