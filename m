Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWD3Uz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWD3Uz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 16:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWD3Uz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 16:55:28 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:1288 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751218AbWD3Uz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 16:55:28 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <jaharkes@cs.cmu.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: C++ pushback
Date: Sun, 30 Apr 2006 13:55:02 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEAPLKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
In-Reply-To: <20060430174828.GA30582@delft.aura.cs.cmu.edu>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sun, 30 Apr 2006 13:51:20 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sun, 30 Apr 2006 13:51:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The C++ standard does not allow an allocator to return NULL, it is
> supposed to raise an exception.
>
> Jan

	It is not that unusual for C++ projects to use no exceptions at all. They
simply replace the default standardized allocators with their own. These
allocators can do whatever you want when memory runs out, including waiting
until more memory is available while acting to reduce memory usage in other
parts of the program.

	You are not forced to use exceptions if you don't want to. Personally, I
don't like them, and I rarely use them, even in large C++ projects (hundreds
of thousands of lines).

	DS


