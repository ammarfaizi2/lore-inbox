Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUFPOsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUFPOsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbUFPOsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:48:37 -0400
Received: from theraft-old.strakt.com ([62.13.29.34]:17795 "EHLO
	theraft.strakt.com") by vger.kernel.org with ESMTP id S263944AbUFPOs3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:48:29 -0400
From: Jacob =?iso-8859-1?q?Hall=E9n?= <jacob@strakt.com>
Organization: AB Strakt
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Airo PCI wlan card not working in kernels after 2.6.2
Date: Wed, 16 Jun 2004 16:48:25 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200406161648.25271.jacob@strakt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Cisco Aironet PCI Wlan card (350 model, I think) which works fine 
under kernel 2.6.2. (I get a report about the card type being unrecognised, 
but it comes up nicely).

However, this card fails to work under any later kernels including 2.6.7.

It is still detected by the kernel, but when trying to get an IP number 
through DHCP it fails.

I have built my newer kernels by copying the 2.6.2 config file and keeping all 
settings as they were. I am building the aironet support as part of the 
kernel and not as a module.

Am I doing something that is obviously wrong or should I submit a fuller bug 
report? If so, should it go to this list, or is it better to go through the 
kernel bugzilla?

Jacob Hallén
