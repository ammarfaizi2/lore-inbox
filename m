Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269493AbTCDShe>; Tue, 4 Mar 2003 13:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269504AbTCDShd>; Tue, 4 Mar 2003 13:37:33 -0500
Received: from amdext2.amd.com ([163.181.251.1]:33021 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S269493AbTCDShc>;
	Tue, 4 Mar 2003 13:37:32 -0500
From: ravikumar.chakaravarthy@amd.com
X-Server-Uuid: BB5E7757-34FD-4146-B9CC-0950D472AE87
Message-ID: <99F2150714F93F448942F9A9F112634CA54B09@txexmtae.amd.com>
To: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: RE: Loading and executing kernel from a non-standard address
 usin g SY SLINUX
Date: Tue, 4 Mar 2003 12:47:39 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 127A2B582106961-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to uncompress it to a different address (actually to a MM5451 card), so that I can test the low memory. Yes my boot loader loads the compressed kernel to 0x200000, and I have modified the kernel to uncompress it and execute it from 0x200000. However I am having problems trying to execute it!!

-Ravi


-----Original Message-----
From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
Sent: Tuesday, March 04, 2003 12:13 PM
To: Chakaravarthy, Ravikumar; linux-kernel@vger.kernel.org
Subject: RE: Loading and executing kernel from a non-standard address usin g SY SLINUX

> Yes the kernel is uncompressed to the right location (0x200000), in my
> case. When I try to uncompress it to a non standard address (other than
> 0x100000), the address mapping is affected. 

Why would you need to uncompress it to a different address? You mention
that your bootloader does something odd, but that should only affect the
address of the compressed bzImage, not the decompressed kernel ...

M.


