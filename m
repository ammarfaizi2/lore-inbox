Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267805AbTAHSAy>; Wed, 8 Jan 2003 13:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267819AbTAHSAy>; Wed, 8 Jan 2003 13:00:54 -0500
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:59403 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S267805AbTAHSAx>;
	Wed, 8 Jan 2003 13:00:53 -0500
Subject: Re: tenth post about PCI code, need help
From: Ray Lee <ray-lk@madrabbit.org>
To: fretre3618@hotmail.com, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042049372.850.921.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 08 Jan 2003 10:09:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. which device is at port address 0xCFB? (please note, NOT 0xCF8)

0xcfb ('bee') is the fourth byte of the 32 bit register that sits/starts
at 0xcf8 ('eight'). Note the difference in the code between the outb and
outl calls.

To answer your other questions, I think you'd have better luck reading
the spec for the x86 pc-style PCI bridge chip, rather than the (generic)
PCI v2.0 spec itself. The spec for the actual chip is always the final
authority for what's going on. (Unless, of course, it's wrong...)

Ray

