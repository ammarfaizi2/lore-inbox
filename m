Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSJYLOf>; Fri, 25 Oct 2002 07:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbSJYLOf>; Fri, 25 Oct 2002 07:14:35 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:17802 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261365AbSJYLOe> convert rfc822-to-8bit; Fri, 25 Oct 2002 07:14:34 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
Subject: Re: Enabling kdb?
Date: Fri, 25 Oct 2002 13:20:41 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210251320.41306.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

> Can any one give information on how to enable the kdb for kernel.
first, compile the kernel with kdb :)

then use kdb=on as bootparam or do echo "1" > /proc/sys/kernel/kdb to activate 
it if you compiled with "KDB off per default".

KDB enters automatically if a panic() occurs or if you press the "Pause" key.

Informations about this and further details:
- cd Documentation/kdb/
- read the man's :)

ciao, Marc
