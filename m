Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275341AbRJBP0x>; Tue, 2 Oct 2001 11:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275338AbRJBP0n>; Tue, 2 Oct 2001 11:26:43 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:14599 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S275337AbRJBP0e>; Tue, 2 Oct 2001 11:26:34 -0400
Date: Tue, 2 Oct 2001 17:26:46 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Sylvain Ravot <sylvain.ravot@cern.ch>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: make: *** [menuconfig] Error 
In-Reply-To: <3BB9C65C.E01FCC05@cern.ch>
Message-ID: <Pine.LNX.4.33.0110021724300.1256-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001, Sylvain Ravot wrote:

> I have the following error message when I try to compile the 2.4.9
> kernel. Could you help me ?
> 
> [root@lxusa linux]# make menuconfig
> 
> scripts/Menuconfig: line 11:  1872 Segmentation fault      (core dumped)

Check your syslog for problems, check your filesystem for errors. If 
none shows up errors, you might have bad RAM - check it with memtest86.

http://www.bitwizard.nl/sig11/

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] ---------------------------------------
When you have multiple CPUs with one interrupt controller, you don't
have much choice. You either use spin-locks or you Blue-Screen.
Since Linux doesn't have a "Blue-screen of death", it needs spin-
locks.
                                               -- Richard B. Johnson
--------------------------------- [ moffe at amagerkollegiet dot dk ] --

