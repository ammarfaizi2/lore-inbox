Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTDXMMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 08:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbTDXMME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 08:12:04 -0400
Received: from 203-236-217-11.rev.nextel.co.kr ([203.236.217.11]:518 "EHLO
	taonetworks.com") by vger.kernel.org with ESMTP id S263548AbTDXMMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 08:12:02 -0400
Date: Thu, 24 Apr 2003 21:24:09 +0900
From: soyoung@taonetworks.com
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
Subject: [Q]About using Netlink socket and endian transition..
Message-ID: <20030424122408.GB60541@taonetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This mail is CC'ed to linux-net mailing list)

Hi, I have a question about netlink socket.
It can be a 'stupid' question, but I need help about it.

The question is : 

"Does it matter to change endian in netlink socket communication?"

Usually there is no endian-transition code in netlink socket program,
but netlink socket is also 'socket', so I think when I want to use 
netlink communication, I have to use endian transition, but no one did it! :)

I'm testing netlink socket for Traffic Control (TC) in MPC8250, 
which is a Motorola PowerPC based CPU.  
TC works good in normal Pentium-based PC, 
but it doesn't look working very well on MPC8250 -  Traffics cannot recognize
their own filters when running through the linux router.  

So I wonder whether this problem is related to netlink endian transition.

Is there anybody who has tested netlink socket in PPC-based platform?

Thanks.
