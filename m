Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTHZUHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTHZUHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:07:35 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:50650 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262736AbTHZUHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:07:33 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-jl9: speedstep-centrino.o: init_module: No such device
Date: Tue, 26 Aug 2003 22:06:36 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308262206.37039.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just patched my 2.4.22 with this patch - so i can get centrino speedstep 
support in 2.4 - but it won't load:

# modprobe speedstep-centrino
/lib/modules/2.4.22-jl9/kernel/arch/i386/kernel/speedstep-centrino.o: 
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-jl9/kernel/arch/i386/kernel/speedstep-centrino.o: insmod 
/lib/modules/2.4.22-jl9/kernel/arch/i386/kernel/speedstep-centrino.o failed
/lib/modules/2.4.22-jl9/kernel/arch/i386/kernel/speedstep-centrino.o: insmod 
speedstep-centrino failed


Any ideas?

Thanks.

Jan

