Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318196AbSIBBJM>; Sun, 1 Sep 2002 21:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318198AbSIBBJM>; Sun, 1 Sep 2002 21:09:12 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:53635 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318196AbSIBBJL> convert rfc822-to-8bit; Sun, 1 Sep 2002 21:09:11 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Michael Bellion <bellion@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: How to determine the amount of free kernel memory?
Date: Mon, 2 Sep 2002 03:08:30 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209020308.30589.bellion@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Is there a way to determine the amount of free kernel memory?
si_meminfo() returns nr_free_pages() for example, but this is
not what I'm looking for.
I want to know the amount of memory that is available to the kernel (via 
vmalloc or kmalloc) without considering userspace memory consumption.

Maybe something like:
nr_active_pages + nr_inactive_pages + nr_free_pages()

I want to use the functionality from within a kernel module, so i don't have 
access to nr_active_pages(), nr_inactive_pages() or nr_free_pages().

Thanks for your help.
	Michael Bellion

