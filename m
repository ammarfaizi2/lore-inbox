Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSH3XWj>; Fri, 30 Aug 2002 19:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSH3XWj>; Fri, 30 Aug 2002 19:22:39 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:62156 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S293680AbSH3XWi>; Fri, 30 Aug 2002 19:22:38 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: <linux-kernel@vger.kernel.org>
Subject: vm_operations .. how to unmap?
Date: Fri, 30 Aug 2002 16:25:24 -0700
Message-ID: <02cd01c2507c$84ec9860$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3D6FF752.B2BDDC66@zip.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am exporting kernel memory to user processes using mmap() entry point of
my driver. Now, when the user calls unmap(), I would like to deallocate the
pages which I allocated at mmap() time. How can I do that? unmap() entry
point is not provided by vm_operations structure in mm.h file.
I will really appreciate any suggestion/guidance.

Thanks,
Imran.

