Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132195AbRCVVJt>; Thu, 22 Mar 2001 16:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132194AbRCVVJk>; Thu, 22 Mar 2001 16:09:40 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:12535 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S132191AbRCVVJV>; Thu, 22 Mar 2001 16:09:21 -0500
Message-ID: <3ABA68EC.89B2DE99@mvista.com>
Date: Thu, 22 Mar 2001 13:04:45 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: eepro100 question: why SCBCmd byte is 0x80?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am trying to get netgear card working on a new (read as potentially buggy
hardware) MIPS board.

The eepro100 driver basically works fine.  It is just after a little while
(usually 2 sec to 15 sec) network communication suddenly stops and I start see
error message like "eepro100: wait_for_cmd_done timeout!".

I looked into this, and it appears that the SCBCmd byte in the command word
has value 0x80 instead of the expected 0.  I looked at the Intel manual, and
it says nothing about the value being 0x80.

Does anybody have a clue here?  I suspect some timing is wrong or a buggy PCI
controller.

Please cc your reply to my email address.  Thanks.

Jun
