Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSL1PJC>; Sat, 28 Dec 2002 10:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSL1PJC>; Sat, 28 Dec 2002 10:09:02 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:27690 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261545AbSL1PJB>; Sat, 28 Dec 2002 10:09:01 -0500
Subject: Kernel panic on 2.4.19 when running netstat
From: Frederik Vanrenterghem <frederik.vanrenterghem@chello.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1041088610.913.5.camel@maui>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 28 Dec 2002 16:16:51 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

when running netstat -a, the kernel panics. Here's some of the output:

Unable to handle kernel paging request at virtual address 00800024
*pde = 0000000000
Oops: 000
CPU: 0
EIP: ....

Process netstat (pid: 1725, stackpage=d7335000)

....

Code: 66 83 7b 24 02 75 4a 8b 94 24 d0 00 00 00 81 44 24 1c 96 00
<0> Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Any idea what might be causing this behaviour?

Best regards,
Frederik
-- 
Frederik Vanrenterghem <frederik.vanrenterghem@chello.be>


