Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277870AbRJNVnG>; Sun, 14 Oct 2001 17:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277868AbRJNVmq>; Sun, 14 Oct 2001 17:42:46 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:7363 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S277866AbRJNVml>; Sun, 14 Oct 2001 17:42:41 -0400
Date: Sun, 14 Oct 2001 16:43:13 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <Pine.LNX.4.33.0110130956350.8707-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110141631020.10941-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You could also look at TOPS-20 for things they did well or unwell.  All
disk I/O in TOPS-20 is done by the VM code; the funky SIN%/SOUT% etc.
simply adjust the mapping window and copy stuff, letting the VM subsystem
schedule I/O as needed.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

