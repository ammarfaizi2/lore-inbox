Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269280AbUJQT0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269280AbUJQT0q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269284AbUJQT0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:26:46 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:10502 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S269280AbUJQT0g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:26:36 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: <davids@webmaster.com>, <martijn@entmoot.nl>,
       "'Linux-Kernel@Vger. Kernel. Org'" <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sun, 17 Oct 2004 12:26:30 -0700
Organization: Cisco Systems
Message-ID: <012c01c4b47f$345071b0$b83147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEBNPBAA.davids@webmaster.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I'm sorry, that's an absolutely preposterous view. For 
> one thing, Linux violates this by allowing processes and 
> threads to share file descriptors (since another process 
> can steal the data before the call to 'recvmsg'). Oh
> well, I guess we'll have to take that out if we want to 
> comply with POSIX on 'select' semantics.

Another typical fake argument. Do not mix kernel and user space problems.

The standard says the [following] recvmsg would not block, not the following
recvmsg *from the same* thread would not block.

Hua


