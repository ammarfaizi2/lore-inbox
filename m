Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVI3RLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVI3RLB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVI3RLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:11:01 -0400
Received: from 216-54-166-16.gen.twtelecom.net ([216.54.166.16]:28372 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1750788AbVI3RLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:11:00 -0400
Message-ID: <433D71A0.1040104@compro.net>
Date: Fri, 30 Sep 2005 13:10:56 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Opterons and setting the pci bus master bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.30.17
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='IP_HTTP_ADDR 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem, I have a number of dual processor Opterons that do not work 
with pci expansion chassis'. The reason that they do not work is because 
none of the cards discovered in the chassis get the pci bus master bit 
set in their command register. If I manually set this bit in our cards 
everything is fine. When we connect the same chassis to an Intel P4 box 
everything is fine. It looks like it is the kernel that sets this bit 
because we have never set it in any of our drivers, yet on the intel 
boxes it gets set. Why would this bit not be set when the chassis is 
connected to an Opteron. We are running 32-bit mode BTW. I am using a 
2.6.11.9 kernel. Is this a motherboard problem or could this be a kernel 
problem?

Thanks
Mark

