Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSLVOa7>; Sun, 22 Dec 2002 09:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSLVOa7>; Sun, 22 Dec 2002 09:30:59 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:37577 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264620AbSLVOa7> convert rfc822-to-8bit; Sun, 22 Dec 2002 09:30:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Read this and be ashamed ;) or: Awfull performance loss since 2.4.18 to 2.4.21-pre2
Date: Sun, 22 Dec 2002 15:38:32 +0100
User-Agent: KMail/1.4.3
References: <200212221439.28075.m.c.p@wolk-project.de>
In-Reply-To: <200212221439.28075.m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212221538.32354.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 December 2002 14:47, Marc-Christian Petersen wrote:

Hi again,

> root@codeman:[/] # uname -r
> 2.4.20
> root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
> 131072+0 records in
> 131072+0 records out
> 2147483648 bytes transferred in 172.327570 seconds (12461637 bytes/sec)

root@codeman:[/] # uname -r
2.4.20-rmap15b
root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
131072+0 records in
131072+0 records out
2147483648 bytes transferred in 140.460427 seconds (15288887 bytes/sec)

ciao, Marc
