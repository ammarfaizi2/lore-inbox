Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130542AbRCDWcU>; Sun, 4 Mar 2001 17:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbRCDWcK>; Sun, 4 Mar 2001 17:32:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43535 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130540AbRCDWby>; Sun, 4 Mar 2001 17:31:54 -0500
Subject: Re: kmalloc() alignment
To: kenn@linux.ie (Kenn Humborg)
Date: Sun, 4 Mar 2001 22:34:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <20010304221711.A1023@excalibur.research.wombat.ie> from "Kenn Humborg" at Mar 04, 2001 10:17:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Zh5G-0005tP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does kmalloc() make any guarantees of the alignment of allocated
> blocks?  Will the returned block always be 4-, 8- or 16-byte
> aligned, for example?

There are people who assume 16byte alignment guarantees. I dont think anyone
has formally specified the guarantee beyond 4 bytes tho
