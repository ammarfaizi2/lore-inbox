Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTEMR7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTEMR73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:59:29 -0400
Received: from ms-smtp-03.southeast.rr.com ([24.93.67.84]:50316 "EHLO
	ms-smtp-03.southeast.rr.com") by vger.kernel.org with ESMTP
	id S263361AbTEMR6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:58:25 -0400
From: Boris Kurktchiev <techstuff@gmx.net>
Reply-To: techstuff@gmx.net
To: linux-kernel@vger.kernel.org
Subject: Re: Posible memory leak!?
Date: Tue, 13 May 2003 14:15:37 -0400
User-Agent: KMail/1.5.1
Cc: vda@port.imtp.ilyichevsk.odessa.ua
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200305131415.37244.techstuff@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

top - 11:03:41 up 4 min,  1 user,  load average: 0.12, 0.20, 0.09
Tasks:  60 total,   1 running,  58 sleeping,   0 stopped,   1 zombie
Cpu(s):   8.3% user,   2.3% system,   0.0% nice,  89.4% idle
Mem:    385904k total,   173996k used,   211908k free,    14244k buffers
Swap:   128512k total,        0k used,   128512k free,    86732k cached

this is what the machine used to look like.

this is what happens when the machine has run for about 3 hours, and during 
that time I have had Netbeans and Day Of Defeat(wine) running for about 15 
minutes.

top - 14:14:49 up  2:31,  1 user,  load average: 0.03, 0.04, 0.01
Tasks:  60 total,   2 running,  57 sleeping,   0 stopped,   1 zombie
Cpu(s):   2.7% user,   0.3% system,   0.0% nice,  97.0% idle
Mem:    385904k total,   261368k used,   124536k free,    16736k buffers
Swap:   128512k total,     8768k used,   119744k free,   175476k cached

if i leave the machine on, and say I start transcoding something.. the RAM 
would not be touched and the swap usage would shoot up to 95%.

