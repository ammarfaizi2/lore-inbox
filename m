Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310579AbSCSJyw>; Tue, 19 Mar 2002 04:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310583AbSCSJyn>; Tue, 19 Mar 2002 04:54:43 -0500
Received: from [65.119.4.9] ([65.119.4.9]:42924 "EHLO
	superglide.netfx-2000.net") by vger.kernel.org with ESMTP
	id <S310579AbSCSJy0>; Tue, 19 Mar 2002 04:54:26 -0500
Date: Tue, 19 Mar 2002 01:54:25 -0800
Message-Id: <200203190954.g2J9sPr17749@superglide.netfx-2000.net>
From: "jason.xia" <dark_knight@linuxfreemail.com>
To: linux-kernel@vger.kernel.org
Subject: 
X-Mailer: Linux Free Mail 2.0
X-IPAddress: 61.151.235.222
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
  I'm reading the codes about linux memory managemnet. and now
I'm puzzled by some codes about __bootmem_alloc_core.
  This function can return a memory address for a memory block.
and it has a parameter "goal" with it to get a preferred address.
But when prev call of this function get a memory block < PAGE_SIZE,
and then call this function with parameter goal and cause
start != bdata->last_pos+1 , the perv memblock has not been
marked reserved and the info will be lost.
  I'm not sure can this happened?
  Thanks.

__best regards__
                                           jason


Get your own FREE E-mail address at http://www.linuxfreemail.com
Linux FREE Mail is 100% FREE, 100% Linux, 100% better, and 100% yours!


