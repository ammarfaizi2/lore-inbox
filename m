Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSHOV5F>; Thu, 15 Aug 2002 17:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSHOV5F>; Thu, 15 Aug 2002 17:57:05 -0400
Received: from amdext.amd.com ([139.95.251.1]:64417 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id <S317521AbSHOV5E>;
	Thu, 15 Aug 2002 17:57:04 -0400
From: harish.vasudeva@amd.com
X-Server-Uuid: 02753650-11b0-11d5-bbc5-00508bf987eb
Message-ID: <CB35231B9D59D311B18600508B0EDF2F04F285C1@caexmta9.amd.com>
To: linux-kernel@vger.kernel.org
Subject: need help with pci_dev..
Date: Thu, 15 Aug 2002 15:00:51 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1142FB1C4811204-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

 i am porting our existing network driver that runs on 2.2.x to kernel 2.4.x. i see that pci_dev struct has changed & it no longer contains the base_address[] field. since our device supports both IOMapped & MMIO Mapped space, it used to get the same from base_address[0] & base_address[1]. with the new kernel, how do i get that?

best regards,
HARISH V


