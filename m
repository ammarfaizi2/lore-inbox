Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSCMAna>; Tue, 12 Mar 2002 19:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291460AbSCMAnV>; Tue, 12 Mar 2002 19:43:21 -0500
Received: from smtprelay6.dc2.adelphia.net ([64.8.50.38]:18568 "EHLO
	smtprelay6.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S291401AbSCMAnO>; Tue, 12 Mar 2002 19:43:14 -0500
Message-ID: <010701c1ca27$dc05fdc0$60d53318@pbc.adelphia.net>
From: "Ben Israel" <ben@genesis-one.com>
To: <linux-kernel@vger.kernel.org>
Subject: Write allocated mallocs
Date: Tue, 12 Mar 2002 19:41:48 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed some unexpected behavior of my Linux 2.4.7 kernel. It appears
that my user level task is only allowed 512 mallocs before each malloc
starts getting physical memory. I want to malloc virtual address space and
only get physical memory when I write to a page. Is this some compiled
constant in the kernel? Are there any ways to get more? Where can I read
about such architecture decisions, so other behavior won't be so unexpected?

Ben Israel


