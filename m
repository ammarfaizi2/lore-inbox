Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUHWRei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUHWRei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUHWReD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:34:03 -0400
Received: from watson.wustl.edu ([128.252.233.1]:22740 "EHLO watson.wustl.edu")
	by vger.kernel.org with ESMTP id S266256AbUHWRa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:30:58 -0400
Message-ID: <412A29D1.80909@watson.wustl.edu>
Date: Mon, 23 Aug 2004 12:30:57 -0500
From: Richard Wohlstadter <rwohlsta@watson.wustl.edu>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.8 + token buffer filter queue discipline causes kernel panic
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.6; VAE: 6.27.0.6; VDF: 6.27.0.26; host: watson.wustl.edu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have 2.6.8 running on my firewall which uses basic NAT masquerading 
iptables rules.  I recently added a token buffer filter to limit my 
outgoing bandwidth.  As soon as I add the tbf with the tc utility it 
causes a kernel panic.  I backed down to the 2.6.7 kernel(latest debian 
compiled) and the kernel panic does not occur.  Is this a known issue 
with 2.6.8 or should I run the oops through ksymoops and further debug 
the issue.  Thanks.

Rich Wohlstadter
