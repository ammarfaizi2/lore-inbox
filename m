Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbSKSGBs>; Tue, 19 Nov 2002 01:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbSKSGBr>; Tue, 19 Nov 2002 01:01:47 -0500
Received: from webmail25.rediffmail.com ([203.199.83.147]:46005 "HELO
	webmail25.rediffmail.com") by vger.kernel.org with SMTP
	id <S267094AbSKSGBr>; Tue, 19 Nov 2002 01:01:47 -0500
Date: 19 Nov 2002 06:07:47 -0000
Message-ID: <20021119060747.18274.qmail@webmail25.rediffmail.com>
MIME-Version: 1.0
From: "Sachin  Sant" <sachinsant@rediffmail.com>
Reply-To: "Sachin  Sant" <sachinsant@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Keyboard Controller / KDB problem on 2.4.18
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am having problem with KDB + 2.4.18-3 SMP kernel . When i come 
out of KDB ,i loose control over keyboard and mouse. I can't 
switch between consoles using keyboard , neither can i use the 
mouse. The machine appears to be in a semi-hung state , as i am 
able to telnet to this machine. Via telnet session if i restart 
the gpm service , i get back the control of keyboard and mouse.
      I tested KDB with 2.5 kernel and found that this problem 
does not occur with 2.5 kernel. The KDB code seems pretty much the 
same for 2.4 and 2.5 kernel. As for the keyboard controller code , 
2.5 is a complete re-write over 2.4 code.
      So as far as 2.5 kernel is concerned the above problem with 
KDB seems to be fixed by the rewrite of keyboard controller 
code.
      Is anyone aware of any fix for the KDB hang problem on 
2.4.18 kernel ? Is there a patch for keyboard controller which i 
can apply over 2.4.18 code to get rid of this KDB hang problem.

Thanks
-Sachin

