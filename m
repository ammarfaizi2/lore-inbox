Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUGIJ4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUGIJ4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbUGIJ4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:56:44 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52415 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S264795AbUGIJyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:54:16 -0400
X-Sasl-enc: tvX45QLDjwRAEp+dQn1kYQ 1089366854
Message-ID: <000401c4659a$b52b76b0$e6afc742@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: <linux-kernel@vger.kernel.org>
Cc: "Chris Mason" <mason@suse.com>
Subject: Re: Processes stuck in unkillable D state (now seen in 2.6.7-mm6)
Date: Fri, 9 Jul 2004 02:52:49 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2149
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As an update, this machine eventually ended up dieing pretty horribly. When 
we found it, there were 100's of procs stuck in D state, and our automated 
"ping" script was reporting all sorts of problems. Anyway we killed off as 
many processes as possible, and did a sysreq-t before trying to reboot. The 
soft reboot failed, and a hard reboot was required.

The newly gathered sysreq output has been placed in the files 
sysreqdmesg3.txt and sysreqmsglog3.txt here:

http://robm.fastmail.fm/kernel/t1/

Rob

