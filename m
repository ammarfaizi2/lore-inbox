Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265554AbTIDVhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265567AbTIDVhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:37:31 -0400
Received: from maja.beep.pl ([195.245.198.10]:20497 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S265554AbTIDVh2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:37:28 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: <linux-kernel@vger.kernel.org>
Subject: serial console after panic() (2.4.21)
Date: Thu, 4 Sep 2003 23:34:19 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309042334.19639.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

serial console stops working immediately when for example root fs cannot be 
mounted - kernel does panic() and serial console no longer works.

With working console I could reboot (send break+b), and choose proper kernel 
from lilo but it doesn't work that way so using own foot to get to company 
and server room is required.

Why code does something that makes serial console usunable in such case?
It seems that not being able to mount root fs isn't so big deal to do 
,,something'' that makes serial console not working.

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

