Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbUBVKNs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 05:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUBVKNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 05:13:48 -0500
Received: from smtp.virgilio.it ([212.216.176.142]:34201 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S261219AbUBVKNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 05:13:46 -0500
From: andreamrl <andreamrl@tiscali.it>
Reply-To: andreamrl@tiscali.it
To: linux-kernel@vger.kernel.org
Subject: Bug in 2.6.3
Date: Sun, 22 Feb 2004 11:14:49 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402221114.49158.andreamrl@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I have just updated from 2.6.2-rc1 to 2.6.3 and i noticed that system 
mathematically crashes when i use xawtv in fullscreen mode, grabdisplay 
capture, and input source from videocomposite1.
The system just crash after less than a minute without logs anything. it's 
stop to respond to keyboard and network. No message to be read on the console 
since the problem happen only in fullscreen mode.
My tv card is a Zoltrix TV Max. I pass the proper tuner and card ID as kernel 
parameters.
The MB is asus nforce2, and the graphics card is a radeon 9200 working with 
radeon X driver (and a chipid override parameter in XConfig)
All worked with 2.6.2-rc1 and 2.4 series. Most probably the problems happened 
also in 2.6.2 or 2.6.1 (i don't remember exactly because when happened i was 
thinking to a ACPI related problem).
Any suggestion to how to debug kernel in such "no log & no info" cases? (i 
have very little experience in kernel debugging, but i'd like at least to 
try.. )
Thanks,

Andrea Merello
