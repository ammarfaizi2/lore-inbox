Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269029AbUJQDa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269029AbUJQDa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 23:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269030AbUJQDa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 23:30:28 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:39378 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269029AbUJQDa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 23:30:27 -0400
Subject: Re: Running user processes in kernel mode; Java and .NET support
	in kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Simon Kissane <skissane@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <82fa66380410152111143f75ec@mail.gmail.com>
References: <82fa66380410152111143f75ec@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097980064.13433.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 17 Oct 2004 03:27:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why would I care ? I need the MMU for paging and to avoid fragmentation
of the system. If I have the MMU on then memory protection checks are
free.

Except in 4G/4G mode syscalls are extremely cheap too nowdays.

Alan

