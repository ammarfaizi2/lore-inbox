Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290120AbSCWCFa>; Fri, 22 Mar 2002 21:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289606AbSCWCFU>; Fri, 22 Mar 2002 21:05:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6927 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289484AbSCWCFF>; Fri, 22 Mar 2002 21:05:05 -0500
Subject: Re: mprotect() api overhead.
To: Tony.P.Lee@nokia.com
Date: Sat, 23 Mar 2002 02:20:37 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A2047@mvebe001.NOE.Nokia.com> from "Tony.P.Lee@nokia.com" at Mar 22, 2002 05:59:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ob93-00019V-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As for SMP case, for my application, it is less an issue, since
> when user call my API in the .so, the mprotect (or that HP=20
> 7 instructions) will open access to the share memory for them
> regardless which CPU they are coming from.  If other thread

That still requires cross processor synchronization - so it will still
take the same hit

Alan

