Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbTLEBaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 20:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTLEBaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 20:30:46 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:59737 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S263778AbTLEBap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 20:30:45 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Larry McVoy'" <lm@bitmover.com>,
       "'Erik Andersen'" <andersen@codepoet.org>,
       "'Zwane Mwaikambo'" <zwane@arm.linux.org.uk>,
       "'Paul Adams'" <padamsdev@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Thu, 4 Dec 2003 17:30:40 -0800
Organization: Cisco Systems
Message-ID: <00c001c3bacf$64cd5240$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20031205012124.GB15799@work.bitmover.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But given that, neither Linus (nor any of you) get to say 
> "well, that's fine for userland but drivers are derived works".  

Indeed. Linus said nowadays kernel modules developed with Linux
specifically in mind are less likely to be considered "not a derived
work" as early days kernel modules.

However, how about user space programs designed specifically for Linux,
and even using Linux specific system calls?

It's definitely a grey area here, and it's not so clear that kernel-user
boundary is stronger than kernel-kernel boundary per se. :-)

Note kernel-user boundary is not just normal system calls. /proc, ioctl
(provided by kernel modules) are also part of it (which are system calls
too but they can be arbitrarily extended).

