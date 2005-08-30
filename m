Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVH3IfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVH3IfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVH3IfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:35:20 -0400
Received: from web53603.mail.yahoo.com ([206.190.37.36]:60020 "HELO
	web53603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751235AbVH3IfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:35:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0e0EvCVRemubi9JZEPsimwsnlfhDzwo2Bg/XXfTCMWIyKAwshIx6sKdlZYOxrolMOzd7TIFGDbKEq3yd4IzXexUl0f1w6JkQtIhvIW6p7L9ZxuXV8kaXV3qnc1Bx/D+wPHslmr1fo29m46OPSwz/8g/MlVOLZf4Kis9wE6SsXRI=  ;
Message-ID: <20050830083512.39846.qmail@web53603.mail.yahoo.com>
Date: Tue, 30 Aug 2005 18:35:12 +1000 (EST)
From: Steve Kieu <haiquy@yahoo.com>
Subject: Very strange Marvell/Yukon Gigabit NIC networking problems
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Ok it sound wierd enough to assume that the latest
kernel 2.6.13 ethernet driver has done something wrong
with the NIC and sustain the condition after reboot or
turn off the machine.

Here is my configuration.

Laptop Asus A4500d. dmesg shows:

eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter

It is working as normal with 2.6.12 and winXP before.
Today I did upgrade the kernel to 2.6.13 and it still
works. The problem is now I switch to the older kernel
that is 2.6.12.5 and .6  it no longer works. dmesg
shows like this:
     
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State


Boot window XP now, and the link always shows that
media disconnected. So the NIC is unuseable with
WinXP, 2.6.12  __but__ still works with 2.6.13. and
power off the machine does not restore the NIC. 

Now of course I am forced to use not only linux but
version 2.6.13 :-) in order to have the NIC working!
Unfortuneately the HSF module with 2.6.13 is not
working because of unresolve symbol so the modem is
dead (I rarely usemodem anyway)

Please help me to recover my NIC back as normal. Thank
you very much indeed. If any other information is
needed pls ask.

Cheers,




S.KIEU

Send instant messages to your online friends http://au.messenger.yahoo.com 
