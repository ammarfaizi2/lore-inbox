Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbSJINBR>; Wed, 9 Oct 2002 09:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbSJINBR>; Wed, 9 Oct 2002 09:01:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2693 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261576AbSJINBR>; Wed, 9 Oct 2002 09:01:17 -0400
Date: Wed, 9 Oct 2002 09:08:44 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writable global section?
In-Reply-To: <Pine.LNX.3.95.1021009090100.31255A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.95.1021009090703.31255B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 
 When using shared libraries, is there a ".section" into which
 I can put a variable that's writable? I note that when programs
 that use shared libraries start, the pages are mprotect(ed)
 PROT_READ|PROT_EXEC, but sometimes I see PROT_WRITE on some
 pages.
 
 I'd like to rip out a memory-mapped semiphore and put it directly
 in a shared library if possible.
 

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

