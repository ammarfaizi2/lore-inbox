Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbSLEUkH>; Thu, 5 Dec 2002 15:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267419AbSLEUkH>; Thu, 5 Dec 2002 15:40:07 -0500
Received: from adsl-64-163-212-31.dsl.snfc21.pacbell.net ([64.163.212.31]:38393
	"EHLO gateway.sf.frob.com") by vger.kernel.org with ESMTP
	id <S267418AbSLEUkG>; Thu, 5 Dec 2002 15:40:06 -0500
Date: Thu, 5 Dec 2002 12:47:40 -0800
Message-Id: <200212052047.gB5Kle620684@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: phil-list@redhat.com
Cc: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: what's the relationship between tgid, tid and pid ?
In-Reply-To: Hu, Boris's message of  Friday, 6 December 2002 03:36:21 +0800 <957BD1C2BF3CD411B6C500A0C944CA260216C228@pdsmsx32.pd.intel.com>
X-Shopping-List: (1) Characteristic honey ponds
   (2) Deboned sycophants
   (3) Constant approval
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems tid = pid, while tgid is head pthread pid. 

"tgid" is the PID of the whole POSIX.1 process.
"pid" is a per-thread PID-like number.

> But the following lines let me confused.

You didn't read the rest of the function to see where it's changed again.
